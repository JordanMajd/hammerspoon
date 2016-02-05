--Constants--
local CMD_ALT = {"cmd", "alt"}
local CMD_ALT_CTRL = {"cmd", "alt", "ctrl"}
--/Constants--

--Config--
hs.window.animationDuration = 0
--/Config

--Layouts--

--/Layouts--

--Functions--
function toast(title, text)
	hs.notify.new({title=title, informativeText=text}):send():release()
end

function alert(text)
	hs.alert(text);
end

function reloadConfig(files)
	doReload = falsed
	for _,file in pairs(files) do
		if file:sub(-4) == ".lua" then
			doReload = true
		end
	end
	if doReload then
		hs.reload()
	end
end

function hs.window.right(window)
	local frame = hs.screen.mainScreen():frame()
	frame.x = frame.x + (frame.w/2)
	frame.w = frame.w/2
	window:setFrame(frame)
end

function hs.window.left(window)
	local frame = hs.screen.mainScreen():frame()
	frame.w = frame.w/2
	window:setFrame(frame)
end

function hs.window.top(window)
	local frame = hs.screen.mainScreen():frame()
	frame.h = frame.h/2
	window:setFrame(frame)
end

function hs.window.bottom(window)
	local frame = hs.screen.mainScreen():frame()
	frame.y = frame.y + (frame.h/2)
	frame.h = frame.h/2
	window:setFrame(frame)
end

function hs.window.maximize(window)
	window:setFrame(hs.screen.mainScreen():fullFrame())
end

function hs.window.minimize(window)
	window:setFrame()
end
--/Functions--

--Key Bindings--

hs.hotkey.bind(CMD_ALT, "right", function()
	hs.window.focusedWindow():right()
end)

hs.hotkey.bind(CMD_ALT, "left", function()
	hs.window.focusedWindow():left()
end)

hs.hotkey.bind(CMD_ALT, "up", function()
	hs.window.focusedWindow():top()
end)

hs.hotkey.bind(CMD_ALT, "down", function()
	hs.window.focusedWindow():bottom()
end)

hs.hotkey.bind(CMD_ALT, "f", function()
	hs.window.focusedWindow():maximize()
end)

hs.hotkey.bind(CMD_ALT, "d", function()
	hs.window.focusedWindow():close()
end)

hs.hotkey.bind(CMD_ALT, "l", function()
	hs.caffeinate.lockScreen()
end)
--/Key Bindings--

--Caffeine--
--Keeps screen awake when caffeinated
local caffeine = hs.menubar.new()
function toggleCaffeine()
	if hs.caffeinate.toggle("displayIdle") then
		caffeine:setTitle("Awake")
	else
		caffeine:setTitle("Tired")
	end
end
caffeine:setClickCallback(toggleCaffeine)
hs.hotkey.bind(CMD_ALT, "c", toggleCaffeine)
toggleCaffeine()
--/Caffeine--

--Autoreload--
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
toast("Hammerspoon","Config Reloaded.");
--/Autoreload--
