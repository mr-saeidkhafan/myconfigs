--[[

     Steamburn Awesome WM theme 3.0
     github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.zenburn_dir                               = require("awful.util").get_themes_dir() .. "zenburn"
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/steamburn"
theme.wallpaper                                 = theme.dir .. "/future.jpg" --gears.wallpaper.set("#222222")
theme.font                                      = "Ubuntu Mono derivative Powerline Regular 12"
theme.fg_normal                                 = "#ffffff"
theme.fg_focus                                  = "#666666"
theme.fg_urgent                                 = "#666666"
theme.bg_normal                                 = "#000000"
theme.bg_focus                                  = "#000000"
theme.bg_urgent                                 = "#000000"
theme.border_width                              = dpi(1)
theme.border_normal                             = "#000000"
theme.border_focus                              = "#777777"
theme.border_marked                             = "#333333"
theme.taglist_fg_focus                          = "#22abff"
theme.tasklist_bg_focus                         = "#111111"
theme.tasklist_fg_focus                         = "#22abff"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.menu_height                               = dpi(16)
theme.menu_width                                = dpi(140)
theme.awesome_icon                              = theme.dir .."/icons/awesome.png"
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = false
theme.useless_gap                               = dpi(0)

-- lain related
theme.layout_txt_termfair                       = "[termfair]"
theme.layout_txt_centerfair                     = "[centerfair]"

local markup = lain.util.markup
local gray   = "#94928F"

-- Textclock
local mytextclock = wibox.widget.textclock(" %H:%M")
mytextclock.font = "Hack 12"

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = "Hack 10",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- CPU
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(theme.font, markup(gray, "cpu ") .. cpu_now.usage .. "% "))
    end
})

-- MEM
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, markup(gray, "mem ") .. mem_now.used .. " "))
    end
})

-- ALSA volume
theme.volume = lain.widget.alsa({
    settings = function()
        header = "vol "
        vlevel  = volume_now.level

        if volume_now.status == "off" then
            vlevel = vlevel .. "M "
        else
            vlevel = vlevel .. " "
        end

        widget:set_markup(markup.font(theme.font, markup(gray, header) .. vlevel))
    end
})

-- Separators
local first = wibox.widget.textbox(markup.font("Terminus 4", " "))
local spr   = wibox.widget.textbox(' ')

function theme.at_screen_connect(s)
    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    --
    -- Create a promptbox for each screen
    s.mytxtlayoutbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mytxtlayoutbox = awful.widget.layoutbox(s)

    s.mytxtlayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function() awful.layout.inc(1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function() awful.layout.inc(-1) end),
                           awful.button({}, 4, function() awful.layout.inc(1) end),
                           awful.button({}, 5, function() awful.layout.inc(-1) end)))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist{
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = awful.util.tasklist_buttons, 
    layout = {
        layout  = wibox.layout.flex.horizontal
    },
    widget_template = {
        {
            {
                {
                    {
                        id     = 'icon_role',
                        widget = wibox.widget.imagebox,
                    },
                    margins = 2,
                    widget  = wibox.container.margin,
                },
                {
                    id     = 'text_role',
                    widget = wibox.widget.textbox,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            left  = 1,
            right = 1,
            widget = wibox.container.margin
        },
        id     = 'background_role',
        widget = wibox.container.background,
      },
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(17) })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            first,
            s.mytaglist,
            spr,
            --spr,
            s.mypromptbox,
            spr,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            awful.widget.keyboardlayout(),
            spr,
            --theme.mail.widget,
            cpu.widget,
            mem.widget,
            theme.volume,
            s.mytxtlayoutbox,
            mytextclock
        },
    }
end

return theme
