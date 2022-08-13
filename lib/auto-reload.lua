local Util = require "lib.util"

--AUTORELOAD--
--watches ~/.hammerspoon directory for changes to .lua and reloads configs
AutoReload = {
	watcher = nil
};

function AutoReload:reloadConfig(files)
	print("reload")
	local doReload = false
	for _,file in pairs(files) do
		if file:sub(-4) == ".lua" then
			doReload = true
		end
	end

	if doReload then
		hs.reload()
	end
end

function AutoReload:init()
  self.watcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", function(paths)
		AutoReload:reloadConfig(paths)
	end):start()
  Util.toast("Hammerspoon","Config Reloaded.");
end

return AutoReload
