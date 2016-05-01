local AutoReload = require "lib.auto-reload"
local Caffeine = require "lib.caffeine"
local GridManager = require "lib.grid-manager"
local ResolutionManager = require "lib.resolution-manager"
local RedshiftManager = require "lib.redshift-manager"
local Conky = require "lib.conky"


AutoReload:init()
Caffeine:init()
GridManager:init()
ResolutionManager:init()
RedshiftManager:init()
Conky:init()

local wv = hs.webview.new(hs.geometry.rect(300, 300, 600, 600))
wv:setLevel(-2147483623) --desktop
wv:url("file:///Users/jmajd/.hammerspoon/www/index.html")
local drawnWV = wv:asHSDrawing()

-- drawnWV:setAlpha(0.5)
drawnWV:show()
wv:show()
