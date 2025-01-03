local Util = require "lib.util"

--resolution-manager.lua
--adds a menu to quickly change screen resolutions
--TODO individual resolution for multiple screens
local ResolutionManager = {
  menu = hs.menubar.new(),
  menuIcon = hs.image.imageFromName("NSActionTemplate")
}

function ResolutionManager:getResolutionsMenuTable()
  local currentScreen = hs.screen.mainScreen()

  local currentMode = currentScreen:currentMode()
  local currentModeEntry = self:getMenuEntryForMode(currentMode)

  local availableModes = currentScreen:availableModes()
  local sortedAvailableModesKeys = Util.sortKeys(availableModes, function(a, b)
    local aGreaterThanB = false

    if a.scale > b.scale then
      aGreaterThanB = true
    elseif a.scale == b.scale and a.w > b.w then
      aGreaterThanB = true
    elseif a.scale == b.scale and a.w == b.w and a.h > b.h then
      aGreaterThanB = true
    end

    return aGreaterThanB
  end)

  local menuTable = {
    currentModeEntry,
    { title = "-" }
  }

  for i, key in ipairs(sortedAvailableModesKeys) do
    local mode = availableModes[key]
    mode.desc = key
    table.insert(menuTable, self:getMenuEntryForMode(mode))
  end

  return menuTable
end

function ResolutionManager:getMenuEntryForMode(mode)
  local me = self

  return {
    title = mode.desc,
    fn = function() me:setResolution(mode) end
  }
end

function ResolutionManager:setResolution(mode)
  hs.screen.mainScreen():setMode(mode.w, mode.h, mode.scale)
end

function ResolutionManager:init()
  self.menu:setMenu(function() return ResolutionManager:getResolutionsMenuTable() end)
  self.menu:setIcon(self.menuIcon)
  self.menu:setTooltip("Select screen resolution")
end

return ResolutionManager
