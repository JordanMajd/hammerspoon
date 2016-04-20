local InputManager = require "lib.input-manager"

--WINDOWMANAGER--
--handles window tiling, full screen and minimize
local WindowManager = {}

function WindowManager.right(window)
	if window then
		local frame = hs.screen.mainScreen():frame()
		frame.x = frame.x + (frame.w/2)
		frame.w = frame.w/2
		window:setFrame(frame)
	end
end

function WindowManager.left(window)
	if window then
		local frame = hs.screen.mainScreen():frame()
		frame.w = frame.w/2
		window:setFrame(frame)
	end
end

function WindowManager.top(window)
	if window then
		local frame = hs.screen.mainScreen():frame()
		frame.h = frame.h/2
		window:setFrame(frame)
	end
end

function WindowManager.bottom(window)
	if window then
		local frame = hs.screen.mainScreen():frame()
		frame.y = frame.y + (frame.h/2)
		frame.h = frame.h/2
		window:setFrame(frame)
	end
end

function WindowManager.maximize(window)
	if window then
		window:setFrame(hs.screen.mainScreen():fullFrame())
	end
end

function WindowManager.minimize(window)
	if window then
		window:setFrame()
	end
end

function WindowManager.init()

	--no window animations--
	hs.window.animationDuration = 0

	--window right half of screen--
	hs.hotkey.bind(InputManager.CMD_ALT, "right", function()
		WindowManager.right(hs.window.focusedWindow())
	end)

	--window left half of screen--
	hs.hotkey.bind(InputManager.CMD_ALT, "left", function()
		WindowManager.left(hs.window.focusedWindow())
	end)

	--window top half of screen--
	hs.hotkey.bind(InputManager.CMD_ALT, "up", function()
		WindowManager.top(hs.window.focusedWindow())
	end)

	--window bottom half of screen--
	hs.hotkey.bind(InputManager.CMD_ALT, "down", function()
		WindowManager.bottom(hs.window.focusedWindow())
	end)

	--window full screen--
	hs.hotkey.bind(InputManager.CMD_ALT, "f", function()
		WindowManager.maximize(hs.window.focusedWindow())
	end)

	--close window--
	hs.hotkey.bind(InputManager.CMD_ALT, "d", function()
		WindowManager.close(hs.window.focusedWindow())
	end)
end

return WindowManager
