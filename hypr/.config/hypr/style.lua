local wal = dofile(os.getenv("HOME") .. "/.config/hypr/wal.lua")

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,

        border_size = 0,
        resize_on_border = false,

        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding       = 0,
        rounding_power = 4,

        active_opacity   = 1.0,
        inactive_opacity = 0.8,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = wal.background,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = false,
    },
})
