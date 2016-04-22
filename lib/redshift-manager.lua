--REDSHIFTMANAGER--
--adjust screen color temperature based on time of day
--todo add menu and keybaord toggle
local Redshift = {}

function Redshift:init()
  hs.redshift.start(1600, "18:00", "07:30", 3600, false)
end

return Redshift
