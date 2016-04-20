--INPUTMANAGER--
--TODO eventually will read a config file and set all inputs here instead of in each module
local InputManager = {
  CMD_ALT = {"cmd", "alt"},
  CMD_ALT_CTRL = {"cmd", "alt", "ctrl"}
}

hs.hotkey.bind(InputManager.CMD_ALT, "l", function()
	hs.caffeinate.lockScreen()
end)

return InputManager
