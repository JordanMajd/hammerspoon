local InputManager = require "lib.input-manager"

--CAFFIENE--
--prevents display and system from sleeping while caffeinated
--disables notifications while caffeinated
local DISPLAY_IDLE = "displayIdle"

local Caffeine = {
  menu = hs.menubar.new(),
  caffeineOnImage = hs.image.imageFromPath("./assets/caffeine-on.pdf"),
  caffeineOffImage = hs.image.imageFromPath("./assets/caffeine-off.pdf")
}

function Caffeine:setTitle(title)
  self.menu:setTitle(title)
end

function Caffeine:setIconOn()
  self.menu:setIcon(self.caffeineOnImage)
  self.menu:setTooltip("Caffienated: notifications off, system sleeping disabled.")
end

function Caffeine:setIconOff()
  self.menu:setIcon(self.caffeineOffImage)
  self.menu:setTooltip("Tired: notifications on, system sleeping enabled.")
end

function Caffeine.enableNotifications()
  hs.execute("launchctl load -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist")
end

function Caffeine.disableNotifications()
    hs.execute("launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist")
end

function Caffeine:toggleCaffeine()
	if hs.caffeinate.get(DISPLAY_IDLE) then
    self:setIconOff()
    --allow display/system to sleep if user is idle
    hs.caffeinate.set(DISPLAY_IDLE, false)
    self.enableNotifications()
	else
    self:setIconOn()
    --do not allow display/system to sleep if user is idle
    hs.caffeinate.set(DISPLAY_IDLE, true)
    self.disableNotifications()
	end
end

function Caffeine:setKeyBindings()
  hs.hotkey.bind(InputManager.CMD_ALT, "c", function()
    Caffeine:toggleCaffeine()
  end)
end

function Caffeine:init()
  --set initial state
  self:setIconOff()
  --allow display/system to sleep if user is idle
  hs.caffeinate.set(DISPLAY_IDLE, false)

  self.enableNotifications()

  self.menu:setClickCallback(function()
    Caffeine:toggleCaffeine()
  end)

  self:setKeyBindings()
end

return Caffeine
