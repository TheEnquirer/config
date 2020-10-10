-- make sure to run: defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/.hammerspoon/init.lua"


ctrlDoublePress = require("ctrlDoublePress")
win = ""


ctrlDoublePress.timeFrame = 0.3


ctrlDoublePress.action = function()
--    do something special
    local alacritty = hs.application.find('alacritty')
    if alacritty:isFrontmost() then
	--alacritty:hide()
	win:focus()
    else
	win = hs.window.focusedWindow()
	hs.application.launchOrFocus("/Applications/Alacritty.app")
    end
 end



