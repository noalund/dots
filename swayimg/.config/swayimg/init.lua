-- general

swayimg.viewer.bind_reset()
swayimg.gallery.thumb_size = 450
swayimg.imagelist.reverse = true
swayimg.imagelist.order = "numeric"
swayimg.imagelist.fsmon = true
swayimg.gallery.preload = false

-- vim bindings (gallery)

swayimg.gallery.on_key("j", function()
    swayimg.gallery.select("down")
end)

swayimg.gallery.on_key("k", function()
    swayimg.gallery.select("up")
end)

swayimg.gallery.on_key("h", function()
    swayimg.gallery.select("left")
end)

swayimg.gallery.on_key("l", function()
    swayimg.gallery.select("right")
end)

swayimg.gallery.on_key("u", function()
    swayimg.gallery.select("pgup")
end)

swayimg.gallery.on_key("d", function()
    swayimg.gallery.select("pgdown")
end)

swayimg.gallery.on_key("g", function()
    swayimg.gallery.select("first")
end)

swayimg.gallery.on_key("Shift-g", function()
    swayimg.gallery.select("last")
end)

-- toggle gallery --> viewer

swayimg.gallery.on_key("Return", function()
    swayimg.mode = "viewer"
end)

-- toggle viewer --> gallery

local function exitViewer()
    swayimg.mode = "gallery"
end

swayimg.viewer.on_key("Return", exitViewer)
swayimg.viewer.on_key("q", exitViewer)
swayimg.viewer.on_key("Escape", exitViewer)

-- vim bindings (viewer)

swayimg.viewer.on_key("n", function()
    swayimg.viewer.open("prev")
end)

swayimg.viewer.on_key("p", function()
    swayimg.viewer.open("next")
end)

swayimg.viewer.on_key("g", function()
    swayimg.viewer.open("first")
end)

swayimg.viewer.on_key("Shift-g", function()
    swayimg.viewer.open("last")
end)

-- vim panning (viewer)

local pan_step = 40

swayimg.viewer.on_key("l", function()
    local pos = swayimg.viewer.get_position()
    swayimg.viewer.set_abs_position(pos.x - pan_step, pos.y)
end)

swayimg.viewer.on_key("h", function()
    local pos = swayimg.viewer.get_position()
    swayimg.viewer.set_abs_position(pos.x + pan_step, pos.y)
end)

swayimg.viewer.on_key("k", function()
    local pos = swayimg.viewer.get_position()
    swayimg.viewer.set_abs_position(pos.x, pos.y + pan_step)
end)

swayimg.viewer.on_key("j", function()
    local pos = swayimg.viewer.get_position()
    swayimg.viewer.set_abs_position(pos.x, pos.y - pan_step)
end)

-- vim zoom in/out (gallery & viewer)

local function clamp(x, min, max)
    return math.max(min, math.min(max, x))
end

swayimg.gallery.on_key("Shift-j", function()
    swayimg.gallery.thumb_size = clamp(swayimg.gallery.thumb_size - 20, 50, 500)
end)

swayimg.gallery.on_key("Shift-k", function()
    swayimg.gallery.thumb_size = clamp(swayimg.gallery.thumb_size + 20, 50, 500)
end)

swayimg.viewer.on_key("Shift-j", function()
    swayimg.viewer.scale = clamp(swayimg.viewer.scale * 0.9, 0.1, 10)
end)

swayimg.viewer.on_key("Shift-k", function()
    swayimg.viewer.scale = clamp(swayimg.viewer.scale * 1.1, 0.1, 10)
end)

-- wallpaper script in gallery mode:

swayimg.gallery.on_key("z", function()
    local img = swayimg.gallery.get_image()
    os.execute("wallpaper \"" .. img.path .. "\" &")
end)

-- wallpaper script in viewer mode:

swayimg.viewer.on_key("z", function()
    local img = swayimg.viewer.get_image()
    os.execute("wallpaper \"" .. img.path .. "\" &")
end)

-- help message (gallery & viewer)

local function show_help(mode)
    if mode == "gallery" then
        swayimg.text.set_status(
            "Help:\n\n" ..
            "shift+j/k - zoom\n" ..
            "j/k/h/l - move\n" ..
            "u/d - page up/down\n" ..
            "g/G - first/last\n" ..
            "Enter - open"
        )
    elseif mode == "viewer" then
        swayimg.text.set_status(
            "Help:\n\n" ..
            "shift+j/k - zoom\n" ..
            "j/k/h/l - pan\n" ..
            "n/p - next/prev\n" ..
            "g/G - first/last"
        )
    end
end

swayimg.gallery.on_key("F1", function()
    show_help("gallery")
end)

swayimg.viewer.on_key("F1", function()
    show_help("viewer")
end)
