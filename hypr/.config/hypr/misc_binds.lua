local mainMod = "SUPER"
local terminal = "kitty"
local fileManager = "yazi"
local menu = "wofi --show drun"
local browser = "firefox"
local lockscreen = "hyprlock"

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd(lockscreen))
hl.bind(mainMod .. " + SHIFT + ESCAPE", hl.dsp.exit())
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(terminal .. " -e " .. fileManager))
hl.bind(mainMod .. " + G", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("pidof wofi && killall wofi || " .. menu))
hl.bind(mainMod .. " + Y", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd("swayimg --gallery ~/pictures/wallpapers"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(terminal .. " -e alsamixer"))

hl.bind(mainMod .. " + O", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(terminal .. " -e aerc -A ~/.email"))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("signal-desktop"))

hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd(terminal .. " -e rmpc"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(terminal .. " -e calcurse"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("~/.local/bin/chat"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(terminal .. " -e swayimg --gallery ~/pictures/iPhoto"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("~/.local/bin/webcam laptop"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(terminal .. " -e nvim ~/vimwiki/index.wiki"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd(terminal .. " -e newsboat -u ~/.rss"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("~/.local/bin/screen-record"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("~/.local/bin/define"))
hl.bind(mainMod .. " + BACKSPACE", hl.dsp.exec_cmd("udiskie-umount -a"))

hl.bind(mainMod .. " + SHIFT + SLASH", hl.dsp.exec_cmd("mpc toggle"))
hl.bind(mainMod .. " + SHIFT + PERIOD", hl.dsp.exec_cmd("mpc next"))
hl.bind(mainMod .. " + SHIFT + COMMA", hl.dsp.exec_cmd("mpc prev"))

hl.bind(mainMod .. " + GRAVE", hl.dsp.exec_cmd("hyprctl switchxkblayout all next"))
