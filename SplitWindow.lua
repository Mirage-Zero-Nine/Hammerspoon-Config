-- lua script for Hammerspoon

local hotkey = require 'hs.hotkey'
local window = require 'hs.window'
local geometry = require 'hs.geometry'
local drawing = require 'hs.drawing'
local mouse = require 'hs.mouse'

local resizeWindow = {'cmd', 'ctrl', 'alt'}

window.animationDuration = 0

-- Resize window --
function resize_window()
    hotkey.bind(resizeWindow, 'M', function() splitResizeWindow('maximize') end)
    hotkey.bind(resizeWindow, 'C', function() splitResizeWindow('center') end)
end

-- Snapback --
hotkey.bind(resizeWindow, '/', function() snapback() end)

-- Local Functions
function splitResizeWindow(type)
    local win = getGoodFocusedWindow(true)
    if not win then return end

    local screen = win:screen()
    local max = screen:frame()
    local state = nil

    if type == 'left' then
         state = geometry.rect(max.x, max.y, max.w / 2, max.h)
    elseif type == 'right' then
         state = geometry.rect(max.x + (max.w / 2), max.y, max.w / 2, max.h)
    elseif type == 'up' then
         state = geometry.rect(max.x, max.y, max.w, max.h / 2)
    elseif type == 'down' then
         state = geometry.rect(max.x, max.y + (max.h / 2), max.w, max.h / 2)
    elseif type == 'maximize' then
         state = geometry.rect(max.x, max.y, max.w, max.h)
    elseif type == 'center' then
        local winState = win:frame()
        local ww = max.w / 2
        local wh = max.h / 2

        state = geometry.rect(max.x + (max.w / 2) - (ww / 2), max.y + (max.h / 2) - (wh / 2), ww, wh)
    else
        return
    end

    setFrame(win, state)
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

--- https://gist.github.com/josephholsten/1e17c7418d9d8ec0e783
--- hs.window:moveToScreen(screen)
--- Method
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
