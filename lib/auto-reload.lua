local Util = require "lib.util"

--AUTORELOAD--
--watches ~/.hammerspoon directory for changes to .lua and reloads configs
AutoReload = {};

function AutoReload.reloadConfig(files)
	
	local doReload = falsed

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
  hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", self.reloadConfig):start()
  Util.toast("Hammerspoon","Config Reloaded.");
end


return AutoReload
