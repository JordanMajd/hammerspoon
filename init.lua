local Caffeine = require "lib.caffeine"
local WindowManager = require "lib.window-manager"
local AutoReload = require "lib.auto-reload"
local InputManager = require "lib.input-manager"
local ResolutionManager = require "lib.resolution-manager"

AutoReload:init()
Caffeine:init()
WindowManager:init()
ResolutionManager:init()
