
--[[
                           
 Vertex Awesome WM theme   
 github.com/copycat-killer 
                           
--]]

local gears   = require ("gears"   )
local redflat = require ("redflat" )
local lain    = require ("lain"    )
local awful   = require ("awful"   )
local wibox   = require ("wibox"   )
local naughty = require ("naughty" )
local vicious       = require ("vicious"             )
local math, string, tonumber, type, os = math, string, tonumber, type, os

local theme                                     = {}

-- Minitray
------------------------------------------------------------
--
theme.widget = {}

theme.widget.margin = {
	tray        = { 2, 2, 2, 2 },
}

theme.default_dir                               = require("awful.util").get_themes_dir() .. "default"
theme.icon_dir                                  = os.getenv("HOME") .. "/.config/awesome/themes/vertex/icons"
theme.wallpaper                                 = os.getenv("HOME") .. "/.config/awesome/themes/vertex/wall.png"
theme.font                                      = "Roboto Bold 10"
theme.taglist_font                              = "FontAwesome 10"
theme.fg_normal                                 = "#FFFFFF"
theme.fg_focus                                  = "#6A95EB"
theme.bg_focus                                  = "#303030"
theme.bg_normal                                 = "#242424"
theme.fg_urgent                                 = "#CC9393"
theme.bg_urgent                                 = "#006B8E"
theme.border_width                              = 4
theme.border_normal                             = "#252525"
theme.border_focus                              = "#7CA2EE"
theme.tooltip_border_color                      = theme.fg_focus
theme.tooltip_border_width                      = theme.border_width
theme.menu_height                               = 24
theme.menu_width                                = 140
theme.awesome_icon                              = theme.icon_dir .. "/awesome.png"
theme.taglist_squares_sel                       = theme.icon_dir .. "/square_sel35.png"
theme.taglist_squares_unsel                     = theme.icon_dir .. "/square_unsel35.png"
theme.panelbg                                   = theme.icon_dir .. "/panel.png"
theme.bat000charging                            = theme.icon_dir .. "/bat-000-charging.png"
theme.bat000                                    = theme.icon_dir .. "/bat-000.png"
theme.bat020charging                            = theme.icon_dir .. "/bat-020-charging.png"
theme.bat020                                    = theme.icon_dir .. "/bat-020.png"
theme.bat040charging                            = theme.icon_dir .. "/bat-040-charging.png"
theme.bat040                                    = theme.icon_dir .. "/bat-040.png"
theme.bat060charging                            = theme.icon_dir .. "/bat-060-charging.png"
theme.bat060                                    = theme.icon_dir .. "/bat-060.png"
theme.bat080charging                            = theme.icon_dir .. "/bat-080-charging.png"
theme.bat080                                    = theme.icon_dir .. "/bat-080.png"
theme.bat100charging                            = theme.icon_dir .. "/bat-100-charging.png"
theme.bat100                                    = theme.icon_dir .. "/bat-100.png"
theme.batcharged                                = theme.icon_dir .. "/bat-charged.png"
theme.ethon                                     = theme.icon_dir .. "/ethernet-connected.png"
theme.ethoff                                    = theme.icon_dir .. "/ethernet-disconnected.png"
theme.volhigh                                   = theme.icon_dir .. "/volume-high.png"
theme.vollow                                    = theme.icon_dir .. "/volume-low.png"
theme.volmed                                    = theme.icon_dir .. "/volume-medium.png"
theme.volmutedblocked                           = theme.icon_dir .. "/volume-muted-blocked.png"
theme.volmuted                                  = theme.icon_dir .. "/volume-muted.png"
theme.voloff                                    = theme.icon_dir .. "/volume-off.png"
theme.wifidisc                                  = theme.icon_dir .. "/wireless-disconnected.png"
theme.wififull                                  = theme.icon_dir .. "/wireless-full.png"
theme.wifihigh                                  = theme.icon_dir .. "/wireless-high.png"
theme.wifilow                                   = theme.icon_dir .. "/wireless-low.png"
theme.wifimed                                   = theme.icon_dir .. "/wireless-medium.png"
theme.wifinone                                  = theme.icon_dir .. "/wireless-none.png"
theme.layout_fairh                              = theme.default_dir.."/layouts/fairhw.png"
theme.layout_fairv                              = theme.default_dir.."/layouts/fairvw.png"
theme.layout_floating                           = theme.default_dir.."/layouts/floatingw.png"
theme.layout_magnifier                          = theme.default_dir.."/layouts/magnifierw.png"
theme.layout_max                                = theme.default_dir.."/layouts/maxw.png"
theme.layout_fullscreen                         = theme.default_dir.."/layouts/fullscreenw.png"
theme.layout_tilebottom                         = theme.default_dir.."/layouts/tilebottomw.png"
theme.layout_tileleft                           = theme.default_dir.."/layouts/tileleftw.png"
theme.layout_tile                               = theme.default_dir.."/layouts/tilew.png"
theme.layout_tiletop                            = theme.default_dir.."/layouts/tiletopw.png"
theme.layout_spiral                             = theme.default_dir.."/layouts/spiralw.png"
theme.layout_dwindle                            = theme.default_dir.."/layouts/dwindlew.png"
theme.layout_cornernw                           = theme.default_dir.."/layouts/cornernww.png"
theme.layout_cornerne                           = theme.default_dir.."/layouts/cornernew.png"
theme.layout_cornersw                           = theme.default_dir.."/layouts/cornersww.png"
theme.layout_cornerse                           = theme.default_dir.."/layouts/cornersew.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = 5
theme.titlebar_close_button_normal              = theme.default_dir.."/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.default_dir.."/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.default_dir.."/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.default_dir.."/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.default_dir.."/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.default_dir.."/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.default_dir.."/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.default_dir.."/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.default_dir.."/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.default_dir.."/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.default_dir.."/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.default_dir.."/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.default_dir.."/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.default_dir.."/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.default_dir.."/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.default_dir.."/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.default_dir.."/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.default_dir.."/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.default_dir.."/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.default_dir.."/titlebar/maximized_focus_active.png"
theme.cpu    = theme.default_dir.."/titlebar/maximized_focus_active.png"






-- http://fontawesome.io/cheatsheet
awful.util.tagnames = { "1: ", "2: ", "3: ", "4: ", "5: ", "6: ", "7: ", "8: ", "9: " }

local markup = lain.util.markup

-- Clock
--os.setlocale(os.getenv("LANG")) -- to localize the clock
local mytextclock = wibox.widget.textclock(markup("#FFFFFF", "%a %d %b, %H:%M"))
mytextclock.font = theme.font
lain.widget.calendar({
    attach_to = { mytextclock },
    notification_preset = {
        fg = "#FFFFFF",
        bg = theme.bg_normal,
        position = "top_right",
        font = "Monospace 10"
    }
})

pmargin = theme.widget.margin
-- Tray widget
--------------------------------------------------------------------------------
local tray = {}
tray.widget = redflat.widget.minitray({ timeout = 10 })
tray.layout = wibox.layout.margin(tray.widget, unpack(pmargin.tray or {}))
tray.widget:buttons(awful.util.table.join(
                      awful.button({}, 1, function() redflat.widget.minitray:toggle() end)
))
-- Mem
local memory = lain.widget.mem({
    settings = function()
      widget:set_markup(markup.fontfg("FontAwesome 10", "#FFFFFF", ": ".. mem_now.used .. "M (" .. mem_now.perc .. "%)"))
    end
})
local memwidget = wibox.container.background(memory.widget, theme.bg_focus, gears.shape.rectangle)
memorywidget = wibox.container.margin(memwidget, 0, 0, 5, 5)


-- Cpu
local cpu = lain.widget.cpu({
    settings = function()
      widget:set_markup(markup.fontfg("FontAwesome 10", "#FFFFFF", ": ".. cpu_now.usage .. "%"))
    end
})
local cpuwidget = wibox.container.background(cpu.widget, theme.bg_focus, gears.shape.rectangle)
CPUwidget = wibox.container.margin(cpuwidget, 0, 0, 5, 5)




-- Battery

local baticon = wibox.widget.imagebox(theme.bat000)
local battooltip = awful.tooltip({
    objects = { baticon },
    margin_leftright = 15,
    margin_topbottom = 12
})
battooltip.wibox.fg = theme.fg_normal
battooltip.textbox.font = theme.font
battooltip.timeout = 0
battooltip:set_shape(function(cr, width, height)
    gears.shape.infobubble(cr, width, height, corner_radius, arrow_size, width - 55)
end)
local bat = lain.widget.bat({
    settings = function()
        local index, perc = "bat", tonumber(bat_now.perc) or 0

        if perc <= 7 then
            index = index .. "000"
        elseif perc <= 20 then
            index = index .. "020"
        elseif perc <= 40 then
            index = index .. "040"
        elseif perc <= 60 then
            index = index .. "060"
        elseif perc <= 80 then
            index = index .. "080"
        elseif perc <= 100 then
            index = index .. "100"
        end

        if bat_now.ac_status == 1 then
            index = index .. "charging"
        end

        baticon:set_image(theme[index])
        battooltip:set_markup(string.format("\n%s%%, %s", bat_now.perc, bat_now.time))
    end
})

-- MPD
theme.mpd = lain.widget.mpd({
    music_dir = "~/Music",
    host = "localhost",
    settings = function()
        if mpd_now.state == "play" then
            title = mpd_now.title
            artist  = "  " .. mpd_now.artist  .. " "
        elseif mpd_now.state == "pause" then
            title = "mpd "
            artist  = "paused "
        else
            title  = ""
            artist = ""
        end

        widget:set_markup(markup.font(theme.font, title .. markup(theme.fg_focus, artist)))
    end
})

-- ALSA volume
local volicon = wibox.widget.imagebox()
theme.volume = lain.widget.alsabar({
    togglechannel = "IEC958,3",
    notification_preset = { font = "Monospace 12", fg = theme.fg_normal },
    settings = function()
        local index, perc = "", tonumber(volume_now.level) or 0

        if volume_now.status == "off" then
            index = "volmutedblocked"
        else
            if perc <= 5 then
                index = "volmuted"
            elseif perc <= 25 then
                index = "vollow"
            elseif perc <= 75 then
                index = "volmed"
            else
                index = "volhigh"
            end
        end

        volicon:set_image(theme[index])
    end
})
volicon:buttons(awful.util.table.join (
          awful.button({}, 1, function()
            awful.spawn.with_shell(string.format("%s -e alsamixer", awful.util.terminal))
          end),
          awful.button({}, 2, function()
            awful.spawn(string.format("%s set %s 100%%", theme.volume.cmd, theme.volume.channel))
            theme.volume.notify()
          end),
          awful.button({}, 3, function()
            awful.spawn(string.format("%s set %s toggle", theme.volume.cmd, theme.volume.togglechannel or theme.volume.channel))
            theme.volume.notify()
          end),
          awful.button({}, 4, function()
            awful.spawn(string.format("%s set %s 1%%+", theme.volume.cmd, theme.volume.channel))
            theme.volume.notify()
          end),
          awful.button({}, 5, function()
            awful.spawn(string.format("%s set %s 1%%-", theme.volume.cmd, theme.volume.channel))
            theme.volume.notify()
          end)
))

-- -- Wifi carrier and signal strength
-- local wificon = wibox.widget.imagebox()
-- local wifitooltip = awful.tooltip({
--     objects = { wificon },
--     margin_leftright = 15,
--     margin_topbottom = 15
-- })
-- wifitooltip.wibox.fg = theme.fg_normal
-- wifitooltip.textbox.font = theme.font
-- wifitooltip.timeout = 0
-- wifitooltip:set_shape(function(cr, width, height)
--     gears.shape.infobubble(cr, width, height, corner_radius, arrow_size, width - 140)
-- end)
-- local mywifisig = lain.widget.watch({
--     cmd = { awful.util.shell, "-c", "awk 'NR==3 {printf(\"%d-%.0f\\n\",$2, $3*10/7)}' /proc/net/wireless; iw dev wlp3s0 link" },
--     settings = function()
--         local carrier, perc = output:match("(%d)-(%d+)")
--         local tiptext = output:gsub("(%d)-(%d+)", ""):gsub("%s+$", "")
--         if carrier == nil and perc == nil and tiptext == "Not connected." then
--             wificon:set_image(theme.wifidisc)
--             wifitooltip:set_markup("No carrier")
--         else
--             perc = tonumber(perc)
--             if perc <= 5 then
--                 wificon:set_image(theme.wifinone)
--             elseif perc <= 25 then
--                 wificon:set_image(theme.wifilow)
--             elseif perc <= 50 then
--                 wificon:set_image(theme.wifimed)
--             elseif perc <= 75 then
--                 wificon:set_image(theme.wifihigh)
--             else
--                 wificon:set_image(theme.wififull)
--             end
--             wifitooltip:set_markup(tiptext)
--         end
--     end
-- })
-- wificon:connect_signal("button::press", function() awful.spawn(string.format("%s -e wavemon", awful.util.terminal)) end)

-- Weather
theme.weather = lain.widget.weather({
    city_id = 2973495 , -- placeholder (London)
    notification_preset = { font = "Monospace 10" },
    settings = function()
        units = math.floor(weather_now["main"]["temp"])
        widget:set_markup(" " .. markup.font(theme.font, units .. "°C") .. " ")
    end
})

-- Launcher
local mylauncher = awful.widget.button({image = theme.awesome_icon})
mylauncher:connect_signal("button::press", function() awful.util.mymainmenu:toggle() end)

-- Separators
local space = wibox.widget.textbox(" ")
local rspace1 = wibox.widget.textbox()
local rspace0 = wibox.widget.textbox()
local rspace2 = wibox.widget.textbox()
local rspace3 = wibox.widget.textbox()
local tspace1 = wibox.widget.textbox()
tspace1.forced_width = 18
rspace1.forced_width = 16
rspace0.forced_width = 18
rspace2.forced_width = 19
rspace3.forced_width = 21

local lspace1 = wibox.widget.textbox()
local lspace2 = wibox.widget.textbox()
local lspace3 = wibox.widget.textbox()
lspace1.forced_height = 18
lspace2.forced_height = 10
lspace3.forced_height = 16

local barcolor = gears.color({
    type  = "linear",
    from  = { 35, 35 },
    to    = { 35, 0 },
    stops = { {0, theme.bg_focus}, {0.9, "#457be7"} }
})

local barcolor2 = gears.color({
    type  = "linear",
    from  = { 35, 35 },
    to    = { 35, 0 },
    stops = { {0, "#323232"}, {1, theme.bg_normal} }
})

function theme.at_screen_connect(s)
    -- Quake application
    -- s.quake = lain.util.quake({ app = awful.util.terminal, border = theme.border_width })

    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
        theme.wallpaper = theme.wallpaper(s)
    end
    gears.wallpaper.maximized(theme.wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    s.mypromptbox.bg = "#00000000"

    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    s.layoutb = wibox.container.margin(s.mylayoutbox, 8, 11, 3, 3)

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons, {

                                         font = theme.taglist_font,
        shape = gears.shape.rectangle,
        spacing = 10,
        square_unsel = theme.square_unsel,
        bg_focus = barcolor
    }, nil, wibox.layout.fixed.horizontal())

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.focused, awful.util.tasklist_buttons, { bg_focus = "#00000000" })

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 25, bg = gears.color.create_png_pattern(theme.panelbg) })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.container.margin(mylauncher, 4, 4, 4, 4),
            s.layoutb,
            rspace0,
            CPUwidget,
            rspace0,
            memorywidget,
            rspace0,
            s.mypromptbox,
        },
        { -- Middle widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.container.constraint(theme.mpd.widget, "exact", 450),
            s.mytaglist,
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mytextclock,
            rspace0,
            theme.weather.icon,
            theme.weather.widget,
            rspace0,
            volicon,
            rspace0,
            baticon,
            rspace0,
            tray.layout,
            -- wibox.widget.systray(),
        },
    }

    -- local dockheight = (40 *  s.workarea.height)/100
    -- local dockshape = function(cr, width, height)
    --   gears.shape.partially_rounded_rect(cr,  width, height, true, true, false, false, 6)
    -- end
    -- s.myleftwibox = wibox({ screen = s, x=0, y=s.workarea.height/2 - dockheight/2, width = 6, height = dockheight, fg = theme.fg_normal, bg = barcolor2, ontop = true, visible = true, type = "dock" })

    -- s.mybottomwibox = awful.wibar({ position = "bottom", screen = s, height = 35,width =530, bg = gears.color.create_png_pattern(theme.panelbg) })
    -- gears.surface.apply_shape_bounding(s.mybottomwibox, dockshape)

    -- Add widgets to the vertical wibox
    -- s.mybottomwibox:setup {
    --   layout = wibox.layout.align.horizontal,
    --     {
    --       layout = wibox.layout.fixed.horizontal,
    --         rspace1,
    --         rspace1,
    --         s.layoutb,
    --         wibox.container.margin(mylauncher, 4, 4, 4, 4),
    --     },
    -- }

    -- Add toggling functionalities
    -- s.docktimer = gears.timer{ timeout = 2 }
    -- s.docktimer:connect_signal("timeout", function()
    --     s.myleftwibox.width = 6
    --     s.layoutb.visible = false
    --     mylauncher.visible = false
    --     s.docktimer:stop()
    -- end)
    -- tag.connect_signal("property::selected", function(t)
    --     s.myleftwibox.width = 40
    --     s.layoutb.visible = true
    --     mylauncher.visible = true
    --     gears.surface.apply_shape_bounding(s.myleftwibox, dockshape)
    --     if not s.docktimer.started then
    --         s.docktimer:start()
    --     end
    -- end)

    -- s.myleftwibox:connect_signal("mouse::leave", function()
    --     s.myleftwibox.width = 6
    --     s.layoutb.visible = false
    --     mylauncher.visible = false
    -- end)

    -- s.myleftwibox:connect_signal("mouse::enter", function()
    --     s.myleftwibox.width = 40
    --     s.layoutb.visible = true
    --     mylauncher.visible = true
    --     gears.surface.apply_shape_bounding(s.myleftwibox, dockshape)
    -- end)
end

return theme
