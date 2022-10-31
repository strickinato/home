-- cmd, alt, crtrl, shift (hyper) --> mapped to RightCMD via karabiner
hyper = {"cmd", "alt", "ctrl", "shift"}
hs.window.animationDuration = 0;

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
  local zoomInstance = hs.application.find("zoom.us")
  if zoomInstance ~= nil then
    hs.application.launchOrFocus("zoom.us")
  else
    hs.alert.show("no zoom")
  end
end)

hs.hotkey.bind(hyper, "n", function()
  hs.application.launchOrFocus("obsidian")
end)

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


-- JIRA LINKING
-- Copied from https://github.com/Hammerspoon/Spoons/blob/4224cddc344198e086715a7c24983f90ec0f32fc/Source/PopupTranslateSelection.spoon/init.lua
-- https://nikhilism.com/post/2021/useful-hammerspoon-tips/
function currentSelection()
   local elem=hs.uielement.focusedElement()
   local sel=nil
   if elem then
      sel=elem:selectedText()
   end
   if (not sel) or (sel == "") then
      hs.eventtap.keyStroke({"cmd"}, "c")
      hs.timer.usleep(20000)
      sel=hs.pasteboard.getContents()
   end
   return (sel or "")
end

function jiraToJiraLink()
    task_id = currentSelection()
    hs.pasteboard.setContents("https://brilliant.atlassian.net/browse/" .. task_id)
    hs.timer.usleep(15000)
    hs.eventtap.keyStroke({"cmd"}, "v")
end

hs.hotkey.bind(hyper, 'j', jiraToJiraLink)

-- House SSID bindings
--
function alertSSID(watcher, message, interface)
  local newSSID = hs.wifi.currentNetwork("en0")
  if wifi ~= newSSID then
    hs.alert.show("connected: " .. newSSID)
    wifi = newSSID
  end
end
wifi = hs.wifi.currentNetwork("en0")
wifiwatcher = hs.wifi.watcher.new(alertSSID)
wifiwatcher:start()

-- Reload


hs.hotkey.bind(hyper, "r", function()
  hs.reload();
end)
hs.alert.show("Config loaded")
