--grid-manager.lua
--handles window tiling, full screen and minimize
local InputManager = require "lib.input-manager"

local GridManager = {}

function GridManager.moveRight(window)
	if window then
		hs.grid.pushWindowRight(window)
	end
end

function GridManager.moveLeft(window)
	if window then
		hs.grid.pushWindowLeft(window)
	end
end

function GridManager.moveUp(window)
	if window then
		hs.grid.pushWindowUp(window)
	end
end

function GridManager.moveDown(window)
	if window then
	   hs.grid.pushWindowDown(window)
	end
end

function GridManager.guiSelect()
		hs.grid.toggleShow()
end

function GridManager.minimize(window)
	if window then
		window:setFrame()
	end
end

function GridManager.increaseWidth(window)
  if window then
    hs.grid.resizeWindowWider(window)
  end
end

function GridManager.decreaseWidth(window)
  if window then
    hs.grid.resizeWindowThinner(window)
  end
end

function GridManager.increaseHeight(window)
  if window then
    hs.grid.resizeWindowTaller(window)
  end
end

function GridManager.decreaseHeight(window)
  if window then
    hs.grid.resizeWindowShorter(window)
  end
end

function GridManager.init()

	--no window animations--
	hs.window.animationDuration = 0

  hs.grid.setMargins(hs.geometry(0, 0))
  for i, screen in ipairs(hs.screen.allScreens()) do
    hs.grid.setGrid('2x2', screen)
  end

	--window right half of screen--
	hs.hotkey.bind(InputManager.CMD_ALT, "right", function()
		GridManager.moveRight(hs.window.focusedWindow())
	end)

	--window left half of screen--
	hs.hotkey.bind(InputManager.CMD_ALT, "left", function()
		GridManager.moveLeft(hs.window.focusedWindow())
	end)

	--window top half of screen--
	hs.hotkey.bind(InputManager.CMD_ALT, "up", function()
		GridManager.moveUp(hs.window.focusedWindow())
	end)

	--window bottom half of screen--
	hs.hotkey.bind(InputManager.CMD_ALT, "down", function()
		GridManager.moveDown(hs.window.focusedWindow())
	end)

	--window full screen--
	hs.hotkey.bind(InputManager.CMD_ALT, "f", function()
		GridManager.maximize(hs.window.focusedWindow())
	end)

	--toggle grid view--
	hs.hotkey.bind(InputManager.CMD_ALT, "s", function()
    GridManager.guiSelect()
	end)

  hs.hotkey.bind(InputManager.CMD_ALT_CTRL, "up", function()
    GridManager.increaseHeight(hs.window.focusedWindow())
  end)

  hs.hotkey.bind(InputManager.CMD_ALT_CTRL, "down", function()
    GridManager.decreaseHeight(hs.window.focusedWindow())
  end)

  hs.hotkey.bind(InputManager.CMD_ALT_CTRL, "right", function()
    GridManager.increaseWidth(hs.window.focusedWindow())
  end)

  hs.hotkey.bind(InputManager.CMD_ALT_CTRL, "left", function()
    GridManager.decreaseWidth(hs.window.focusedWindow())
  end)
end

return GridManager
