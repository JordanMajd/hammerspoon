local AutoReload = require "lib.auto-reload"
local Caffeine = require "lib.caffeine"
local GridManager = require "lib.grid-manager"
local ResolutionManager = require "lib.resolution-manager"
local RedshiftManager = require "lib.redshift-manager"


AutoReload:init()
Caffeine:init()
GridManager:init()
ResolutionManager:init()
RedshiftManager:init()
