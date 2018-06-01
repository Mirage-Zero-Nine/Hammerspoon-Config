-- lua script for Hammerspoon

local window = require 'hs.window'
local geometry = require 'hs.geometry'

function set_center_large()

    -- Get current focused window
    local win = hs.window.focusedWindow()
    local screen = win:screen()

    -- Find max value of current screen
    local max = screen:frame()

    -- Window frame class
    local f = win:frame()

    -- Set parameter of window frame
    f.x = max.x + max.w / 20
    f.y = max.y + max.h / 20
    f.w = max.w * (8 / 9)
    f.h = max.h * (8 / 9)

    -- Set window frame
    win:setFrame(f)
end

function set_right_two_third()
    -- Get current focused window
    local win = hs.window.focusedWindow()
    local screen = win:screen()

    -- Find max value of current screen
    local max = screen:frame()

    -- Window frame class
    local f = win:frame()

    -- Set parameter of window frame
    f.x = max.x + (max.w / 3)
    f.y = max.y
    f.w = max.w * 2 / 3
    f.h = max.h

    -- Set window frame
    win:setFrame(f)
end

function set_max()
    
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
    f.w = max.w
    f.h = max.h
    
    -- Set window frame
    win:setFrame(f)
end

function set_left_forth()

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
    f.w = max.w / 4
    f.h = max.h

    -- Set window frame
    win:setFrame(f)
  end

function set_window(app_name, set_window_function, event)
    event = event or hs.window.filter.windowFocused

    hs.window.filter.new(app_name)

    -- :subscribe(event, function()set_current_windows_size()end)
    :subscribe(event, function()set_window_function()end)
end

function start_auto_set_window_size()
    -- Add window you want to auto resize here.
    set_window('Mail', set_center_large, hs.window.filter.windowFocused)    
    set_window('Messages', set_right_two_third, hs.window.filter.windowFocused)    
end
