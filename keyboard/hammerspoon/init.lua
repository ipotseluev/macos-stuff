hs.hotkey.bind({"alt", "shift"}, "t", function()
    local alacritty = hs.application.find('alacritty')
    if alacritty then
        if alacritty:isFrontmost() then
            alacritty:hide()
        else
            alacritty:activate()
        end
    else
        hs.application.launchOrFocus('/Applications/Alacritty.app')
    end
end)

-- Define the key remappings
local remapKeys = {
  -- Ctrl+n to Down Arrow
  {{"ctrl"}, "n", nil, function()
    hs.eventtap.keyStroke({}, "down")
  end},

  -- Ctrl+p to Up Arrow
  {{"ctrl"}, "p", nil, function()
    hs.eventtap.keyStroke({}, "up")
  end},

  -- Ctrl+j to Return
  {{"ctrl"}, "j", nil, function()
    hs.eventtap.keyStroke({}, "return")
  end}
}


-- PROBLEM: On MBP keyboard, '`' and '~' are located to the left from 'z'
-- instead of to the left from '1'
--: Use device vendor/product IDs
local keyRemap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
    local keyCode = event:getKeyCode()
    local flags = event:getFlags()

    if keyCode == 10 then -- § key
        if flags.shift then
            -- Send ~ (tilde) - just the shifted backtick
            hs.eventtap.keyStroke({'shift'}, '`', 0)
        else
            -- Send ` (backtick)
            hs.eventtap.keyStroke({}, '`', 0)
        end
        return true -- Suppress the original key event
    end

    return false
end):start()
