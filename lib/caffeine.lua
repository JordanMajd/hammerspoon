local InputManager = require "lib.input-manager"

--CAFFIENE--
--prevents display and system from sleeping while caffeinated
--disables notifications while caffeinated
local DISPLAY_IDLE = "displayIdle"

local Caffeine = {
  menu = hs.menubar.new(),
}

function Caffeine:setTitle(title)
  self.menu:setTitle(title)
end

function Caffeine.enableNotifications()
  hs.execute("launchctl load -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist")
end

function Caffeine.disableNotifications()
    hs.execute("launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist")
end

function Caffeine:toggleCaffeine()
	if hs.caffeinate.get(DISPLAY_IDLE) then
    self:setTitle("Tired")
    --allow display/system to sleep if user is idle
    hs.caffeinate.set(DISPLAY_IDLE, false)
    self.enableNotifications()
	else
    self:setTitle("Awake")
    --do not allow display/system to sleep if user is idle
    hs.caffeinate.set(DISPLAY_IDLE, true)
    self.disableNotifications()
	end
end

function Caffeine:init()
  --set initial state
  self:setTitle("Tired")
  --allow display/system to sleep if user is idle
  hs.caffeinate.set(DISPLAY_IDLE, false)

  self.enableNotifications()

  self.menu:setClickCallback(function()
    Caffeine:toggleCaffeine()
  end)

  hs.hotkey.bind(InputManager.CMD_ALT, "c", function()
    Caffeine:toggleCaffeine()
  end)
end

return Caffeine
