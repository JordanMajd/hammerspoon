--CONSTANTS--
local CMD_ALT = {"cmd", "alt"}
local CMD_ALT_CTRL = {"cmd", "alt", "ctrl"}
--/CONSTANTS--

--CONFIG--
--no window animations--
hs.window.animationDuration = 0
--/CONFIG--

--LAYOUTS--

--/LAYOUTS--

--FUNCTIONS--
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
--/FUNCTIONS--

--KEY BINDINGS--
--window right half of screen--
hs.hotkey.bind(CMD_ALT, "right", function()
	hs.window.focusedWindow():right()
end)

--window left half of screen--
hs.hotkey.bind(CMD_ALT, "left", function()
	hs.window.focusedWindow():left()
end)

--window top half of screen--
hs.hotkey.bind(CMD_ALT, "up", function()
	hs.window.focusedWindow():top()
end)

--window bottom half of screen--
hs.hotkey.bind(CMD_ALT, "down", function()
	hs.window.focusedWindow():bottom()
end)

--window full screen--
hs.hotkey.bind(CMD_ALT, "f", function()
	hs.window.focusedWindow():maximize()
end)

--close window--
hs.hotkey.bind(CMD_ALT, "d", function()
	hs.window.focusedWindow():close()
end)

--lock screen--
hs.hotkey.bind(CMD_ALT, "l", function()
	hs.caffeinate.lockScreen()
end)

--test toast--
hs.hotkey.bind(CMD_ALT, "t", function()
	toast("test")
end)
--/KEY BINDINGS--

--CAFFIENE--
--keeps screen awake when caffeinated
--disables notifications when caffeinated
local caffeine = hs.menubar.new()
function toggleCaffeine()
	if hs.caffeinate.toggle("displayIdle") then
		caffeine:setTitle("Awake")
		hs.execute("launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist")
	else
		caffeine:setTitle("Tired")
		hs.execute("launchctl load -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist")
	end
end
caffeine:setClickCallback(toggleCaffeine)
hs.hotkey.bind(CMD_ALT, "c", toggleCaffeine)
toggleCaffeine()
--/CAFFIENE--

--AUTORELOAD--
--watches hammerspoon config for changes and reloads--
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
toast("Hammerspoon","Config Reloaded.");
--/AUTORELOAD--

--NOTES AND SUCH--
--[[
--sudo defaults write /System/Library/LaunchAgents/com.apple.notificationcenterui KeepAlive -bool False
lordbunson: what sort of commands do you want to run? We have hs.execute() which is really simple and blocks while the command runs, or you can use hs.task for
            excellent features (like running a command in the background)
Ng: and for files, we don't provide anything specific, but there are the stock Lua library functions (specifically, the 'io' library)
Ng:http://lua-users.org/wiki/IoLibraryTutorial is probably going to cover what you need for handling files
< Ng:(although if you are using files to store settings/data, you might want to look at whether hs.settings can cover your needs)
]]--
--/NOTES AND SUCH--
