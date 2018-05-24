-- lua script for Hammerspoon


function Chinese()
    -- hs.keycodes.setMethod("Pinyin - Simplified")
    hs.keycodes.currentSourceID("com.apple.inputmethod.SCIM.ITABC")
end
  
function English()
    -- hs.keycodes.setLayout("U.S.")
    hs.keycodes.currentSourceID("com.apple.keylayout.US")
end

function set_app_input_method(app_name, set_input_method_function, event)
    event = event or hs.window.filter.windowFocused

    hs.window.filter.new(app_name)
    :subscribe(event, function()
                 set_input_method_function()
              end)
end

-- Some samples
function start_language_switch()
    set_app_input_method('Dictionary', English, hs.window.filter.windowFocused)
    set_app_input_method('Finder', English, hs.window.filter.windowFocused)
    set_app_input_method('Google Chrome', English, hs.window.filter.windowFocused)
    set_app_input_method('IntelliJ', English, hs.window.filter.windowFocused)

    set_app_input_method('Messages', Chinese, hs.window.filter.windowFocused)
end
