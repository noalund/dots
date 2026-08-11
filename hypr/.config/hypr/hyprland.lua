require("sys_binds")
require("misc_binds")
require("style")

-- monitors
hl.monitor({ output = "HDMI-A-1", mode = "3840x2160", position = "0x0", scale = 1.5 })
hl.monitor({ output = "DP-1", mode = "3840x2160", position = "0x0", scale = 1.5 })
hl.monitor({ output = "eDP-1", mode = "2880x1800", position = "2560x0", scale = 2 })

-- autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("dunst")
    hl.exec_cmd("mpd")
    hl.exec_cmd("udiskie -a")
end)

-- environment variables
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})

-- enable swallowing
hl.config({
    misc = {
        enable_swallow = true,
        swallow_regex = "^(kitty)$",
    },
})

-- input
hl.config({
    input = {
        kb_layout  = "us,de",
        kb_variant = "",
        kb_model   = "",
        kb_options = "compose:ralt",
        kb_rules   = "",

	follow_mouse   = 0,
	natural_scroll = true,
	sensitivity    = 0,

        touchpad = {
            natural_scroll = true,
        },
    },
})

-- devices
hl.device({
    name        = "syna802e:00-06cb:cfa8-touchpad",
    middle_button_emulation = false,
    natural_scroll = true,
    clickfinger_behavior = true
})

hl.device({
    name        = "tpps/2-elan-trackpoint",
    sensitivity = -0.5
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})
