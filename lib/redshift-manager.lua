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

  hs.redshift.stop()
  Util.alert(self.temperature .. 'K')
  --TODO set so it lasts longer period of time
  hs.redshift.start(self.temperature, os.date("%H:%M"), "12:00")
end

function Redshift:turnUp()

  if self.temperature <= 9900 then
    self.temperature = self.temperature + 100
  end

  hs.redshift.stop()
  Util.alert(self.temperature .. '')
  --TODO set so it lasts longer period of time
  hs.redshift.start(self.temperature, os.date("%H:%M"), "12:00")
end

function Redshift:reset()
  hs.redshift.stop()
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
