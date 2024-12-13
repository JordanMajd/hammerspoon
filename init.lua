local AutoReload = require "lib.auto-reload"
local GridManager = require "lib.grid-manager"
local ResolutionManager = require "lib.resolution-manager"
local RedshiftManager = require "lib.redshift-manager"
local Conky = require "lib.conky"

AutoReload:init()
GridManager:init()
ResolutionManager:init()
RedshiftManager:init()
Conky:init()

print("Hammerspoon loaded")