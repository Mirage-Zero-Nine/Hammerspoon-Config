-- lua script for Hammerspoon

local hotkey = require 'hs.hotkey'
local window = require 'hs.window'
local geometry = require 'hs.geometry'
local drawing = require 'hs.drawing'
local mouse = require 'hs.mouse'

window.animationDuration = 0

local moveMouse = {'cmd'}

-- Snapback
hotkey.bind(hyperSize, '/', function() snapback() end)

-- Function that can be used in init.lua
function move_mouse()
    -- Move mouse between monitors ⌘ + 1 / 2 
    hotkey.bind(moveMouse, '2', function() moveMouseOneScreen('next') end)
    hotkey.bind(moveMouse, '1', function() moveMouseOneScreen('previous') end)
end

-- Local Functions
local mouseState = {}
function moveMouseOneScreen(type)
    local screen = mouse.getCurrentScreen()

    local toScreen = nil
    if type == 'next' then
        toScreen = screen:next()
    elseif type == 'previous' then
        toScreen = screen:previous()
    else
        return
    end

    local rect = screen:fullFrame()
    local toRect = toScreen:fullFrame()

    local pos = mouse.getRelativePosition()
    local toPos = nil

    local toScreenId = toScreen:id()
    if mouseState[toScreenId] then
        toPos = mouseState[toScreenId]
    else
        local x = pos.x / rect.w * toRect.w
        local y = pos.y / rect.h * toRect.h
        toPos = geometry.point(x, y)
    end
 
    mouse.setRelativePosition(toPos, toScreen)
    mouseState[screen:id()] = pos

    mouseHighlight()
end

local snapbackStates = {} 
function snapback()
    local win = getGoodFocusedWindow()
    if not win then return end

    local id = win:id()
    local state = win:frame()
    local prevState = snapbackStates[id]
    if prevState then
        win:setFrame(prevState)
    end
    snapbackStates[id] = state
end

function getGoodFocusedWindow(isNoFull)
    local win = window.focusedWindow()
    if not win or not win:isStandard() then return end
    if isNoFull and win:isFullScreen() then return end
    return win
end

function setFrame(win, unit)
    if not win then
        return nil
    end

    local id = win:id()
    local state = win:frame()
    snapbackStates[id] = state
    return win:setFrame(unit)
end

local mouseCircle = nil
local mouseCircleTimer = nil

function mouseHighlight()
    -- Delete an existing highlight if it exists
    if mouseCircle then
        mouseCircle:delete()
        if mouseCircleTimer then
            mouseCircleTimer:stop()
        end
    end
    -- Get the current co-ordinates of the mouse pointer
    mousepoint = mouse.getAbsolutePosition()
    -- Prepare a big red circle around the mouse pointer
    mouseCircle = drawing.circle(geometry.rect(mousepoint.x - 40, mousepoint.y - 40, 80, 80))
    mouseCircle:setStrokeColor({["red"] = 1, ["blue"] = 0, ["green"] = 0, ["alpha"] = 1})
    mouseCircle:setFill(false)
    mouseCircle:setStrokeWidth(5)
    mouseCircle:show()

    -- Set a timer to delete the circle after n seconds
    mouseCircleTimer = hs.timer.doAfter(.3, function() mouseCircle:delete() end)
end

--- https://gist.github.com/josephholsten/1e17c7418d9d8ec0e783
--- hs.window:moveToScreen(screen)
--- move window to the the given screen, keeping the relative proportion and position window to the original screen.
--- Example: win:moveToScreen(win:screen():next()) -- move window to next screen
function hs.window:moveToScreen(nextScreen)
    local currentFrame = self:frame()
    local screenFrame = self:screen():frame()
    local nextScreenFrame = nextScreen:frame()
    self:setFrame({
        x = ((((currentFrame.x - screenFrame.x) / screenFrame.w) * nextScreenFrame.w) + nextScreenFrame.x),
        y = ((((currentFrame.y - screenFrame.y) / screenFrame.h) * nextScreenFrame.h) + nextScreenFrame.y),
        h = currentFrame.h,
        w = currentFrame.w
    })
end
