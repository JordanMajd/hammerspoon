local Util = require "lib.util"

--REDSHIFTMANAGER--
--adjust screen color temperature based on time of day
--todo add menu and keybaord toggle
local Redshift = {
  upMenu = hs.menubar.new(),
  resetMenu = hs.menubar.new(),
  downMenu = hs.menubar.new(),
  temperature = 1600
}

function Redshift:turnDown()

  if self.temperature >= 1100 then
    self.temperature = self.temperature - 100
  end
  
  self:setTemp()
end

function Redshift:turnUp()

  if self.temperature <= 9900 then
    self.temperature = self.temperature + 100
  end

  self:setTemp()
end

--TODO change to dropdown menu to stop, start, invert
function Redshift:reset()
  hs.redshift.stop()
end

function Redshift:setTemp()

    local currentHour = tonumber(os.date("%H"))
    local currentMin = tonumber(os.date("%M"))

    local endHour = currentHour + 12
    if endHour > 23 then
      endHour = endHour - 23
    end

    hs.redshift.stop()

    hs.redshift.start(self.temperature, os.date("%H:%M"), tostring(endHour) .. ":" .. tostring(currentMin), 0)

    Util.alert(self.temperature .. 'K')
end

function Redshift:init()

  local me = self

  self.upMenu:setIcon(hs.image.imageFromName("NSGoRightTemplate"))
  self.upMenu:setClickCallback(function()
      me:turnUp()
  end)

  self.resetMenu:setIcon(hs.image.imageFromName("NSRefreshTemplate"))
  self.resetMenu:setClickCallback(function()
    me:reset()
  end)

  self.downMenu:setIcon(hs.image.imageFromName("NSGoLeftTemplate"))
  self.downMenu:setClickCallback(function()
      me:turnDown()
  end)

end


return Redshift
