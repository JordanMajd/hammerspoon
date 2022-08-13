local InputManager = require "lib.input-manager"

--CAFFIENE--
--prevents display and system from sleeping while caffeinated
--Currently broken: disables notifications while caffeinated
--regularly registers user activity to keep chat status active
local DISPLAY_IDLE = "displayIdle"

local Caffeine = {
  menu = hs.menubar.new(),
  caffeineOnImage = hs.image.imageFromPath("./assets/caffeine-on.pdf"),
  caffeineOffImage = hs.image.imageFromPath("./assets/caffeine-off.pdf"),
  timer = nil
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

function Caffeine:enableNotifications()
  -- local shortcuts = hs.shortcuts.list()
  -- for i, value in ipairs(shortcuts) do
  --   print(value)
  -- end
  -- hs.execute([[defaults -currentHost write ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturb -boolean false]])
  -- hs.execute([[killall NotificationCenter]])
end

function Caffeine:disableNotifications()
  -- hs.execute([[set -eou pipefail]])
  -- hs.execute([[defaults -currentHost write ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturb -boolean true]])
  -- hs.execute([[defaults -currentHost write ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturbDate -date "`date -u +\"%Y-%m-%d %H:%M:%S +0000\"`"]])
  -- hs.execute([[killall NotificationCenter]])
end

function Caffeine:disable()
  self:setIconOff()
  --allow display/system to sleep if user is idle
  hs.caffeinate.set(DISPLAY_IDLE, false)
  self:enableNotifications()
  self:disableMouseTwitch()
end

function Caffeine:enable()
  self:setIconOn()
  --do not allow display/system to sleep if user is idle
  hs.caffeinate.set(DISPLAY_IDLE, true)
  self:disableNotifications()
  self:enableMouseTwitch()
end

function Caffeine:toggleCaffeine()
	if hs.caffeinate.get(DISPLAY_IDLE) then
    self:disable()
	else
    self:enable()
	end
end

function Caffeine:setKeyBindings()
  hs.hotkey.bind(InputManager.CMD_ALT, "c", function()
    Caffeine:toggleCaffeine()
  end)
end

function Caffeine:enableMouseTwitch()
  self.timer = hs.timer.doEvery(5, function()
    hs.caffeinate.declareUserActivity()
    -- local curPoint = hs.mouse.absolutePosition()
    -- local amount = math.floor(math.random(100))
    -- local newPoint = { x = curPoint.x - amount, y = curPoint.y - amount }
    -- if curPoint.x % 2 == 0 then
    --   newPoint = { x = curPoint.x + amount, y = curPoint.y + amount }
    -- end
    -- hs.mouse.absolutePosition(newPoint)
  end)
end

function Caffeine:disableMouseTwitch()
  if self.timer ~= nil then
    self.timer:stop()
  end
end

function Caffeine:init()
  -- ensure in disabled state initially
  self:disable()

  self.menu:setClickCallback(function()
    Caffeine:toggleCaffeine()
  end)
  self:setKeyBindings()
end

return Caffeine
