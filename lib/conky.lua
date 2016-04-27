local Util = require "lib.util"

--conky.lua
--WIP
--Eventually going to be a desktop dashboard for CPU, disk and network stats

local Conky = {
  tickRate = 10,
  background = nil,
  backgroundDimensions = hs.geometry.rect(0, 50, 400, 800),
  backgroundColor = {red=0, blue=0, green=0, alpha=0.65},
  text = nil,
  textDimensions = hs.geometry.rect(0, 60, 400, 800),
  textColor = {red=1, blue=1, green=1, alpha=1},
  imageDimensions = hs.geometry.rect(100, 100, 400, 400),
  image = nil
}

function Conky:init()

  local me = self

  self:initBackground()
  self:initText()
  -- self:initImage()

  hs.timer.doEvery(self.tickRate, function()
    me:updateText()
  end)
end

function Conky:initBackground()
  self.background = hs.drawing.rectangle(self.backgroundDimensions)
  self.background:setFill(true)
  self.background:setStroke(false)
  self.background:setFillColor(self.backgroundColor)
  self.background:setLevel("desktop")
  self.background:setBehavior(1)
  self.background:show()
end

function Conky:initText()
  self.text = hs.drawing.text(self.textDimensions, "")
  -- self.text:setTextColor(self.textColor)
  -- self.text:setTextSize(12)
  self.text:setLevel("desktop")
  self.text:setBehavior(1)
  self.text:orderAbove(self.background)

  self:updateText()

  self.text:show()
end

-- function Conky:initImage()
--
--   local ascii =  [[
--   ....5....
--   ....#....
--   ....#....
--   ....#....
--   ..1.#.3..
--   ...#5#...
--   6...2...9
--   #.......#
--   7#######8
--   ]]
--
--
--   self.image = hs.drawing.image(self.imageDimensions, hs.image.imageFromASCII(ascii))
--   self.image:setFill(true)
--   self.image:setStroke(true)
--   self.image:setFillColor(self.textColor)
--   self.image:setLevel("desktop")
--   self.image:orderAbove(self.background)
--   self.image:orderAbove(self.text)
--   self.image:show()
--
-- end

function Conky:updateText()

  local cpuHeader = "CPU Usage: \n"
  local cpuUsage = Util:toString(hs.host.cpuUsage())

  local addressesHeader = "Addresses: \n"
  local addresses = Util:toString(hs.host.addresses())

  local fullText = cpuHeader .. cpuUsage .. addressesHeader .. addresses

  local style = {
    paragraphStyle = {
      alignment = "justified"
    },
    font = {
      name = hs.styledtext.defaultFonts.system,
      size = 12
    },
    color = {red=0, blue=0, green=1, alpha=1}
  }

  local styledText = hs.styledtext.new(fullText, style)

  self.text:setStyledText(styledText)

end

return Conky
