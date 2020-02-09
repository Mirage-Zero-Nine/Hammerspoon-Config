-- lua script for Hammerspoon
-- Set window to left or right half of screen.
local window = require 'hs.window'
local geometry = require 'hs.geometry'
local hotkey = require 'hs.hotkey'
-- The origin 0,0 is at the top left corner of the primary screen. 
-- (Screens to the left of the primary screen, or above it, and windows on these screens, will have negative coordinates)

local windowLayout = {'cmd', 'ctrl'}

function set_left_half()
    hotkey.bind(windowLayout, 'l', function() left_half() end)
end

function set_right_half()
    hotkey.bind(windowLayout, 'r', function() right_half() end)
end

function left_half()

    -- Get current focused window
    local win = hs.window.focusedWindow()
    local screen = win:screen()

    -- Find max value of current screen
    local max = screen:frame()

    -- Window frame class
    local f = win:frame()

    -- Set parameter of window frame
    f.x = max.x
    f.y = max.y
    f.w = max.w * 0.5
    f.h = max.h

    -- Set window frame
    win:setFrame(f)
end

function right_half()

    -- Get current focused window
    local win = hs.window.focusedWindow()
    local screen = win:screen()

    -- Find max value of current screen
    local max = screen:frame()

    -- Window frame class
    local f = win:frame()

    -- Set parameter of window frame
    f.x = max.x + max.w * 0.5
    f.y = max.y
    f.w = max.w * 0.5
    f.h = max.h

    -- Set window frame
    win:setFrame(f)
end
