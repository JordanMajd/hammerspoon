local Caffeine = require "lib.caffeine"
local WindowManager = require "lib.window-manager"
local AutoReload = require "lib.auto-reload"
local InputManager = require "lib.input-manager"
local ResolutionManager = require "lib.resolution-manager"
local RedshiftManager = require "lib.redshift-manager"
local GridManager = require "lib.grid-manager"

AutoReload:init()
Caffeine:init()
-- WindowManager:init()
GridManager:init()
ResolutionManager:init()
-- RedshiftManager:init()
