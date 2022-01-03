-- cmd, alt, crtrl, shift (hyper) --> mapped to RightCMD via karabiner
hyper = {"cmd", "alt", "ctrl", "shift"}


hs.hotkey.bind(hyper, "w", function()
  hs.application.launchOrFocus("Google Chrome")
end)

hs.hotkey.bind(hyper, "e", function()
  hs.application.launchOrFocus("emacs")
end)

hs.hotkey.bind(hyper, "t", function()
  hs.application.launchOrFocus("iterm")
end)

hs.hotkey.bind(hyper, "s", function()
  hs.application.launchOrFocus("slack")
end)

hs.hotkey.bind(hyper, "z", function()
  hs.application.launchOrFocus("zoom.us")
end)

hs.hotkey.bind(hyper, "r", function()
  hs.reload();
end)
hs.alert.show("Config loaded")

-- Moving windows around

frameCache = {}

function toggle_fullscreen()
  local win = hs.window.focusedWindow()
  if frameCache[win:id()] then
    win:setFrame(frameCache[win:id()])
    frameCache[win:id()] = nil
  else
    frameCache[win:id()] = win:frame()
    win:maximize()
  end
end

three_mods = { "cmd", "alt", "ctrl" }
hs.hotkey.bind(three_mods, "up", function()
  toggle_fullscreen()
end)
hs.hotkey.bind(three_mods, "left", function()
  local win = hs.window.focusedWindow()
  win:move(hs.layout.left50)
end)

hs.hotkey.bind(three_mods, "right", function()
  local win = hs.window.focusedWindow()
  win:move(hs.layout.right50)
end)
