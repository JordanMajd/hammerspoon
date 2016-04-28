local Util = require "lib.util"

--conky.lua
--Eventually going to be a desktop dashboard for CPU, disk and network stats
local Conky = {
  tickRate = 10,
  background = nil,
  backgroundDimensions = hs.geometry.rect(0, 50, 165, 350),
  backgroundColor = {red=0, blue=0, green=0, alpha=0.65},
  text = nil,
  textDimensions = hs.geometry.rect(10, 60, 165, 350),
  bodyStyle = {
    paragraphStyle = {
      alignment = "left"
    },
    font = {
      name = "Monaco",
      size = 12
    },
    color = { red=0, blue=0, green=1, alpha=1 }
  },
  breakStyle = {
    paragraphStyle = {
      alignment = "left"
    },
    font = {
      name = ".AppleSystemUIFont",
      size = 18
    },
    color = { red=1, blue=1, green=1, alpha=0.5 }
  },
  headerStyle = {
    paragraphStyle = {
      alignment = "left"
    },
    font = {
      name = ".AppleSystemUIFont",
      size = 18
    },
    color = { red=1, blue=1, green=1, alpha=1 }
  },

  netConfig = hs.network.configuration.open()
}

function Conky:init()

  local me = self
  print(hs.styledtext.defaultFonts.label)
  self:initBackground()
  self:initText()

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
  self.text:setLevel("desktop")
  self.text:setBehavior(1)
  self.text:orderAbove(self.background)
  self:updateText()
  self.text:show()
end

function Conky:updateText()

  local text = hs.styledtext.new("", {})

  local systemText = hs.host.localizedName() .. "\n"
  systemText = systemText .. self.netConfig:consoleUser() .."\n"

  local systemName = hs.styledtext.new(systemText, self.headerStyle)
  text = text:__concat(systemName)

  local cpuUsage = self:getCpuUsage()
  text = text:__concat(cpuUsage)

  local vmStats = self:getVmStats()
  text = text:__concat(vmStats)

  self.text:setStyledText(text)

end

function Conky:getCpuUsage()

  local returnText = hs.styledtext.new("", {})
  returnText = returnText:__concat(self:getSeparator())

  local cpuUsage = hs.host.cpuUsage()

  local cpuHeader = hs.styledtext.new("CPU Usage: \n", self.headerStyle)
  returnText = returnText:__concat(cpuHeader)
  returnText = returnText:__concat(self:getSeparator())

  local cpuStr = "Num. Cores: " .. cpuUsage.n .. "\n"
  local usage = string.format("%.2f", tonumber(cpuUsage.overall.idle) / tonumber(cpuUsage.overall.active))
  cpuStr = cpuStr .. "- Overall: " .. tostring(usage) .. "%\n"

  for i, stat in ipairs(cpuUsage) do
    if stat and stat.active and stat.idle then
      local usage = string.format("%.2f", tonumber(stat.idle) / tonumber(stat.active))
      cpuStr = cpuStr .. "- Core #" .. tostring(i) .. ": " .. tostring(usage) .. "%\n"
    end
  end

  local cpuBody = hs.styledtext.new(cpuStr, self.bodyStyle)
  returnText = returnText:__concat(cpuBody)

  return returnText

end

function Conky:getVmStats()

  local returnText = hs.styledtext.new("", {})
  returnText = returnText:__concat(self:getSeparator())


  local vmStats = hs.host.vmStat()

  local vmHeader = hs.styledtext.new("VM Stats: \n", self.headerStyle)
  returnText = returnText:__concat(vmHeader)
  returnText = returnText:__concat(self:getSeparator())

  --1024^2
  local megDiv = 1048576
  local megMulti = vmStats.pageSize / megDiv


  -- Mem Used:
  -- Wired Memory: -> Pages wired down
  -- Compressed: -> Pages occupied by compressor
  -- App Memory: -> Pages Active + Pages Speculative
  --http://apple.stackexchange.com/questions/81581/why-does-free-active-inactive-speculative-wired-not-equal-total-ram
  local megsUsed =  vmStats.pagesWiredDown * megMulti
  megsUsed = megsUsed + vmStats.pagesUsedByVMCompressor * megMulti
  megsUsed = megsUsed + vmStats.pagesActive * megMulti
  megsUsed = megsUsed + vmStats.pagesSpeculative * megMulti

  local totalMegs = vmStats.memSize / megDiv
  local freeMegs = totalMegs - megsUsed

  local megsCached = vmStats.fileBackedPages * megMulti

  local vmBodyText =         "In Use: " .. string.format("%.f", megsUsed) .. "M - ".. string.format("%.f", megsUsed / totalMegs * 100) .. "%\n"
  vmBodyText = vmBodyText .. "Free  : " .. string.format("%.f", freeMegs) .. "M - ".. string.format("%.f", freeMegs / totalMegs * 100) .. "%\n"
  vmBodyText = vmBodyText .. "Total : " .. string.format("%.f", totalMegs) .. "M\n"
  vmBodyText = vmBodyText .. "Cached: " .. string.format("%.f", megsCached) .. "M\n"
  local vmBody = hs.styledtext.new(vmBodyText, self.bodyStyle)
  returnText = returnText:__concat(vmBody)

  return returnText
end

function Conky:getSeparator()
  return hs.styledtext.new("-----------------\n", self.breakStyle)
end

return Conky
