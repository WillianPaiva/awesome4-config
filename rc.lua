-- Standard awesome library
local gears         = require ("gears"               )
local awful         = require ("awful"               )
require                       ("awful.autofocus"     )
local timer = require("gears.timer")
-- Widget and layout library
local wibox         = require ("wibox"               )
-- Theme handling library
local beautiful     = require ("beautiful"           )
-- Notification library
local naughty       = require ("naughty"             )
local menubar       = require ("menubar"             )
local hotkeys_popup = require ("awful.hotkeys_popup" ).widget
local lain          = require ("lain"                )
local redflat       = require ("redflat"             )
local vicious       = require ("vicious"             )
local shape         = require ("gears.shape"         )
local system        = redflat.system
local separator     = redflat.gauge.separator
--notify limit icon size

naughty.config.presets.normal.icon_size   = 50
naughty.config.presets.low.icon_size      = 50
naughty.config.presets.critical.icon_size = 50

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}


-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.



local theme_path = os.getenv("HOME") .. "/.config/awesome/themes/holo"
beautiful.init(theme_path .. "/theme.lua")


-- This is used later as the default terminal and editor to run.
local terminal = "termite"
local editor = os.getenv("EDITOR") or "emacs"
local editor_cmd = terminal .. " -e " .. editor
local fm = "thunar"
local gui_editor = "emacsclient -nc --socket-name /tmp/emacs1000/server"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
local modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.spiral,
  awful.layout.suit.spiral.dwindle,
  awful.layout.suit.max,
  awful.layout.suit.max.fullscreen,
  awful.layout.suit.magnifier,
  awful.layout.suit.corner.nw,
  awful.layout.suit.floating,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- check theme
local pmargin

if beautiful.widget and beautiful.widget.margin then
	pmargin = beautiful.widget.margin
else
	pmargin = { double_sep = {} }
end
-- Separators
--------------------------------------------------------------------------------
local single_sep = separator.vertical({ margin = pmargin.single_sep })


-- Tray widget
--------------------------------------------------------------------------------
--local tray = {}
--tray.widget = redflat.widget.minitray({ timeout = 10 })
--tray.layout = wibox.layout.margin(tray.widget, unpack(pmargin.tray or {}))
--tray.widget:buttons(awful.util.table.join(
                      --awful.button({}, 1, function() redflat.widget.minitray:toggle() end)
--))
-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Textclock widget
--------------------------------------------------------------------------------
local textclock = {}
textclock.widget = redflat.widget.textclock({ timeformat = "%H:%M", dateformat = "%b  %d  %a" })
textclock.layout = wibox.layout.margin(textclock.widget, unpack(pmargin.textclock or {}))

-- Create a wibox for each screen and add it
local taglist_buttons = awful.util.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- ALSA volume bar
volicon = wibox.widget.imagebox(beautiful.vol)
volume = lain.widgets.alsabar({
    card   = "0",
    ticks  = true,
    width  = 80,
    height = 10,
    colors = {
      background = "#383838",
      unmute     = "#80CCE6",
      mute       = "#FF9F9F"
    },
    notifications = {
      font      = "Tamsyn",
      font_size = "12",
      bar_size  = 32
    }
})
volumebg = wibox.container.background(volume.bar, beautiful.widget_bg, shape.rectangle)
volumewidget = wibox.container.margin(volumebg, 2, 2, 10, 10)
-- ALSA volume bar



-- baticon = wibox.widget.imagebox(beautiful.bat)
-- bat = wibox.widget {
--   max_value     = 1,
--   value         = 0.33,
--   forced_width  = 70,
--   shape         = gears.shape.powerline,
--   border_width  = 2,
--   border_color  = beautiful.border_color,
--   widget        = wibox.widget.progressbar,
--   background_color = "#494B4F",
--   -- color = { type = "linear", from = { 0, 0 }, to = { 0, 10 }, stops = {{ 0, "#AECF96" }, { 0.5, "#88A175" }, { 1, "#FF5656" }}},
--   color = "#E53935",
-- }
-- batwidget = wibox.container.margin(bat, 0, 0, 6, 6)
-- vicious.register(bat, vicious.widgets.bat, "$2", 61, "BAT0")

-- Taglist configure
--------------------------------------------------------------------------------
local taglist = {}
taglist.style  = { widget = redflat.gauge.orangetag.new }
taglist.margin = pmargin.taglist

taglist.buttons = awful.util.table.join(
	awful.button({ modkey    }, 1, awful.client.movetotag),
	awful.button({           }, 1, awful.tag.viewonly    ),
	awful.button({           }, 2, awful.tag.viewtoggle  ),
	awful.button({ modkey    }, 3, awful.client.toggletag),
	awful.button({           }, 3, function(t) redflat.widget.layoutbox:toggle_menu(t)    end),
	awful.button({           }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
	awful.button({           }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)



cpuicon = wibox.widget.imagebox(beautiful.cpu)
cpu = wibox.widget {
  max_value     = 1,
  value         = 0.33,
  forced_width  = 70,
  border_width  = 2,
  border_color  = beautiful.border_color,
  widget        = wibox.widget.graph,
  background_color = "#494B4F",
  color = "#3949AB",
}
cpuwidget = wibox.container.margin(cpu, 0, 7, 6, 6)
vicious.register(cpu, vicious.widgets.cpu, "$1", 3)



memicon = wibox.widget.imagebox(beautiful.mem)
mem = wibox.widget {
  max_value     = 1,
  value         = 0.33,
  forced_width  = 70,
  border_width  = 2,
  border_color  = beautiful.border_color,
  widget        = wibox.widget.graph,
  background_color = "#494B4F",
  color = "#00897B",
}
memwidget = wibox.container.margin(mem, 0, 0, 6, 6)
vicious.cache(vicious.widgets.mem)
vicious.register(mem, vicious.widgets.mem, "$1", 13)

-- mpdwidget = wibox.widget{
--   align  = 'center',
--   valign = 'center',
--   widget = wibox.widget.textbox
-- }
-- vicious.register(mpdwidget, vicious.widgets.mpd,
--                  function (widget, args)
--                    if   args["{state}"] == "Stop" then return ""
--                    else return '<span color="white">MPD:</span> '..
--                        args["{Artist}"]..' - '.. args["{Title}"]
--                    end
-- end)

-- MPD
markup = lain.util.markup
blue   = "#80CCE6"
space3 = markup.font("Tamsyn 3", " ")
space2 = markup.font("Tamsyn 2", " ")

-- MPD
mpd_icon = wibox.widget.imagebox()
mpd_icon:set_image(beautiful.mpd)
prev_icon = wibox.widget.imagebox()
prev_icon:set_image(beautiful.prev)
next_icon = wibox.widget.imagebox()
next_icon:set_image(beautiful.nex)
stop_icon = wibox.widget.imagebox()
stop_icon:set_image(beautiful.stop)
pause_icon = wibox.widget.imagebox()
pause_icon:set_image(beautiful.pause)
play_pause_icon = wibox.widget.imagebox()
play_pause_icon:set_image(beautiful.play)

mpdwidget = lain.widgets.mpd({
    settings = function ()
        if mpd_now.state == "play" then
            mpd_now.artist = mpd_now.artist:upper():gsub("&.-;", string.lower)
            mpd_now.title = mpd_now.title:upper():gsub("&.-;", string.lower)
            widget:set_markup(markup.font("Tamsyn 4", " ")
                              .. markup.font("Tamsyn 8",
                              mpd_now.artist
                              .. " - " ..
                              mpd_now.title
                              .. markup.font("Tamsyn 10", " ")))
            play_pause_icon:set_image(beautiful.pause)
        elseif mpd_now.state == "pause" then
            widget:set_markup(markup.font("Tamsyn 4", " ") ..
                              markup.font("Tamsyn 8", "MPD PAUSED") ..
                              markup.font("Tamsyn 10", " "))
            play_pause_icon:set_image(beautiful.play)
        else
            widget:set_markup("")
            play_pause_icon:set_image(beautiful.play)
        end
    end
})

musicwidget = wibox.widget.background()
musicwidget:set_widget(mpdwidget)
musicwidget:set_bgimage(beautiful.widget_bg)
musicwidget:buttons(awful.util.table.join(awful.button({ }, 1,
function () awful.util.spawn_with_shell(musicplr) end)))
mpd_icon:buttons(awful.util.table.join(awful.button({ }, 1,
function () awful.util.spawn_with_shell(musicplr) end)))
prev_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
    awful.util.spawn_with_shell("mpc prev || ncmpc prev || pms prev")
    mpdwidget.update()
end)))
next_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
    awful.util.spawn_with_shell("mpc next || ncmpc next || pms next")
    mpdwidget.update()
end)))
stop_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
    play_pause_icon:set_image(beautiful.play)
    mpdwidget.update()
end)))
awful.util.spawn_with_shell("mpc stop || ncmpc stop || pms stop")
play_pause_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
    awful.util.spawn_with_shell("mpc toggle || ncmpc toggle || pms toggle")
    mpdwidget.update()
end)))


-- Battery

batwidget = lain.widgets.bat({
    ac = "AC",
    settings = function()
      bat_header = " Bat "
      bat_p      = bat_now.perc .. " "
      if bat_now.ac_status == 1 then
        bat_p = bat_p .. "Plugged "
      end
      widget:set_markup(markup(blue, bat_header) .. bat_p)
    end
})
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
-- screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    -- set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({"一 ", "二 ", "三 ", "四 ", "五 ","六 ","七 ","八 ","九 "  }, s, awful.layout.layouts[1])
    -- awful.tag({"","" }, s, awful.layout.layouts[1])

    -- awful.tag.add("", {
    --                 icon               = os.getenv("HOME") .. "/.config/awesome/themes/holo/material-design-icons/image/1x_web/ic_filter_1_black_48dp.png",
    --               layout             = awful.layout.layouts[1],
    --               screen             = s,
    --           })
    -- awful.tag.add("", {
    --                 icon               = os.getenv("HOME") .. "/.config/awesome/themes/holo/material-design-icons/image/1x_web/ic_filter_2_black_48dp.png",
    --                 layout             = awful.layout.layouts[1],
    --               screen             = s,
    --           })
    -- awful.tag.add("", {
    --                 icon               = os.getenv("HOME") .. "/.config/awesome/themes/holo/material-design-icons/image/1x_web/ic_filter_3_black_48dp.png",
    --               layout             = awful.layout.layouts[1],
    --               screen             = s,
    --           })
    -- awful.tag.add("", {
    --                 icon               = os.getenv("HOME") .. "/.config/awesome/themes/holo/material-design-icons/image/1x_web/ic_filter_4_black_48dp.png",
    --               layout             = awful.layout.layouts[1],
    --               screen             = s,
    --           })

    -- awful.tag.add("", {
    --                 icon               = os.getenv("HOME") .. "/.config/awesome/themes/holo/material-design-icons/image/1x_web/ic_filter_5_black_48dp.png",
    --               layout             = awful.layout.layouts[1],
    --               screen             = s,
    --           })

    -- awful.tag.add("", {
    --                 icon               = os.getenv("HOME") .. "/.config/awesome/themes/holo/material-design-icons/image/1x_web/ic_filter_6_black_48dp.png",
    --               layout             = awful.layout.layouts[1],
    --               screen             = s,
    --           })

    -- awful.tag.add("", {
    --                 icon               = os.getenv("HOME") .. "/.config/awesome/themes/holo/material-design-icons/image/1x_web/ic_filter_7_black_48dp.png",
    --               layout             = awful.layout.layouts[1],
    --               screen             = s,
    --           })
    -- awful.tag.add("", {
    --                 icon               = os.getenv("HOME") .. "/.config/awesome/themes/holo/material-design-icons/image/1x_web/ic_filter_8_black_48dp.png",
    --                 layout             = awful.layout.layouts[1],
    --               layout             = awful.layout.layouts[1],
    --               screen             = s,
    --               bg = "test",
    --           })
    -- awful.tag.add("", {
    --                 icon               = os.getenv("HOME") .. "/.config/awesome/themes/holo/material-design-icons/image/1x_web/ic_filter_9_black_48dp.png",
    --                 layout             = awful.layout.layouts[1],
    --                 screen             = s,
    --                 bg = "test",
    -- })


    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget

    -- Layoutbox configure
    -- this widget used as icon for main menu
    --------------------------------------------------------------------------------

    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a taglist widget
    -- s.taglist = {}
    -- s.taglist.widget = redflat.widget.taglist(s, redflat.widget.taglist.filter.all, taglist.buttons, taglist.style)
    -- s.taglist.layout = wibox.layout.margin(s.taglist.widget, unpack({8,8,0,0}))

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 32 })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.flex.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            prev_icon,
            play_pause_icon,
            next_icon,
            mpd_icon,
            musicwidget,
        },
        {-- Middle widget
        layout = wibox.layout.align.horizontal,
          {
          layout = wibox.layout.fixed.horizontal,
          align  = "center",
          s.mytaglist,
          s.mypromptbox,
          },
          {
          layout = wibox.layout.fixed.horizontal,
          },
          {
          layout = wibox.layout.fixed.horizontal,
          wibox.widget.systray(),
          },
        },

        { -- Right widgets
        layout = wibox.layout.align.horizontal,
            {
              layout = wibox.layout.fixed.horizontal,
              batwidget,
              volicon,
              volumewidget,
            },
            {
              layout = wibox.layout.fixed.horizontal,
              cpuicon,
              cpuwidget,
              memicon,
              memwidget,
            },
            {
              layout = wibox.layout.fixed.horizontal,
              textclock.layout,
              s.mylayoutbox,
            },
        },
    }

end)
-- }}}

local volume_raise = function() redflat.widget.pulse:change_volume({ show_notify = true })              end
local volume_lower = function() redflat.widget.pulse:change_volume({ show_notify = true, down = true }) end
local volume_mute  = function() redflat.widget.pulse:mute() end
-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

local function delete_tag()
  local t = awful.screen.focused().selected_tag
  if not t then return end
  t:delete()
end

local function add_tag()
  awful.tag.add("NewTag",{
                  screen= awful.screen.focused(),
                  layout= awful.layout.layouts[1],
  }):view_only()
end

local function rename_tag()
  awful.prompt.run {
    prompt       = "New tag name: ",
    textbox      = awful.screen.focused().mypromptbox.widget,
    exe_callback = function(new_name)
      if not new_name or #new_name == 0 then return end

      local t = awful.screen.focused().selected_tag
      if t then
        t.name = new_name
      end
    end
  }
end

local function copy_tag()
  local t = awful.screen.focused().selected_tag
  if not t then return end

  local clients = t:clients()
  local t2 = awful.tag.add(t.name, awful.tag.getdata(t))
  t2:clients(clients)
  t2:view_only()
end

local function move_to_new_tag()
  local c = client.focus
  if not c then return end

  local t = awful.tag.add(c.class,{screen= c.screen,
                                   layout= awful.layout.layouts[1],
  })
  c:tags({t})
  t:view_only()
end


-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "F1",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),

    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),

    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),

    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
      {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
      function ()
        awful.client.focus.bydirection("down")
      end,
      {description = "Focus client below", group = "client"}
    ),

    awful.key({ modkey,           }, "k",
      function ()
        awful.client.focus.bydirection("up")
      end,
      {description = "Focus client above", group = "client"}
    ),

    awful.key({ modkey,           }, "h",
      function ()
        awful.client.focus.bydirection("left")
      end,
      {description = "Focus left client", group = "client"}
    ),

    awful.key({ modkey,           }, "l",
      function ()
        awful.client.focus.bydirection("right")
      end,
      {description = "Focus right client", group = "client"}
    ),

    awful.key({ modkey,           }, "a", add_tag,
      {description = "add a tag", group = "tag"}),
    awful.key({ modkey, "Shift"   }, "a", delete_tag,
      {description = "delete the current tag", group = "tag"}),

    awful.key({ modkey, "Control"   }, "a", move_to_new_tag,
      {description = "add a tag with the focused client", group = "tag"}),

    awful.key({ modkey, "Mod1"   }, "a", copy_tag,
      {description = "create a copy of the current tag", group = "tag"}),

    awful.key({ modkey, }, "r", rename_tag,
      {description = "rename the current tag", group = "tag"}),

    awful.key({ modkey,           }, "w", function() awful.util.spawn("kbpm --database /home/willian/Dropbox/keepass.kdbx --password 'W634901w*'"  ) end,
              {description = "show keepass dmenu", group = "launcher"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),

    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),

    awful.key({ modkey, "Control" }, "h", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),

    awful.key({ modkey, "Control" }, "l", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),

    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),

    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),

    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),

    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),


    awful.key({ modkey,"Shift"}, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,"Shift"}, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),

    -- awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
    --           {description = "increase the number of master clients", group = "layout"}),

    -- awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
    --           {description = "decrease the number of master clients", group = "layout"}),

    -- awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
    --           {description = "increase the number of columns", group = "layout"}),

    -- awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
    --           {description = "decrease the number of columns", group = "layout"}),

    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),

    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    -- awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
    --           {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p",function() awful.util.spawn("rofi -show run"  ) end,
              {description = "show rofi", group = "launcher"}),

    awful.key({ modkey }, "q",function() awful.util.spawn("qutebrowser"  ) end,
      {description = "qutebrowser", group = "launcher"}),

    awful.key({ modkey }, "d",function() awful.util.spawn("thunar"  ) end,
      {description = "thunar", group = "launcher"}),

    awful.key({ modkey }, "t",function() awful.util.spawn("transmission-gtk"  ) end,
      {description = "transmission", group = "launcher"}),

    awful.key({ modkey }, "s",function() awful.util.spawn(gui_editor) end,
      {description = "emacs", group = "launcher"}),

    awful.key({ }, "XF86AudioPlay",function() awful.util.spawn("mpc toggle") end,
      {description = "Play/Pause", group = "MPD"}),

    awful.key({ }, "XF86AudioNext",function() awful.util.spawn("mpc next") end,
      {description = "Next Track", group = "MPD"}),

    awful.key({  }, "XF86AudioPrev",function() awful.util.spawn("mpc prev") end,
      {description = "Previous track", group = "MPD"}),

    awful.key({  }, "XF86AudioRaiseVolume",function() awful.util.spawn("amixer -q sset Master 3%+")
        volume.update();
                                           end,
      {description = "increase volume", group = "Volume Control"}),

    awful.key({  }, "XF86AudioLowerVolume",function() awful.util.spawn("amixer -q sset Master 3%-")
        volume.update();
                                           end,
      {description = "reduce volume", group = "Volume Control"})





)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
      awful.key({ modkey,"Shift"           }, "s",      function (c) c.sticky = not c.sticky            end,
              {description = "toggle sticky", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
                 }, properties = { titlebars_enabled = false }
    },
    {
      rule = { class = "MPlayer" },
      properties = { floating = true }
    },
    {
      rule = { class = "xterm" },
      properties = { floating = true }
    },
    {
      rule = { class = "mpv" },
      properties = { floating = true,
                     sticky = true,
                     ontop = true,
      }
    },
    {
      rule = { class = "Conky" },
      properties = { floating = true,
                     sticky = true,
                     ontop = false,
                     border_width = 0,
                     focusable = false,
                     size_hints = {"program_position", "program_size"}
      }
    },
    {
      rule       = { class = "Gimp" }, except = { role = "gimp-image-window" },
      properties = { floating = true }
    },
    {
      rule       = { class = "Firefox" }, except = { role = "browser" },
      properties = { floating = true }
    },
    {
      rule_any   = { class = { "pinentry", "Plugin-container", "Acyl.py" } },
      properties = { floating = true }
    },
    {
      rule       = { class = "Key-mon" },
      properties = { sticky = true }
    },
    {
      rule = { class = "Exaile" },
      callback = function(c)
        for _, exist in ipairs(awful.client.visible(c.screen)) do
          if c ~= exist and c.class == exist.class then
            awful.client.floating.set(c, true)
            return
          end
        end
        awful.client.movetotag(tags[1][2], c)
        c.minimized = true
      end
    }

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)
local function apply_shape(draw, shape, ...)
  local geo = draw:geometry()
  local shape_args = ...

  local img = cairo.ImageSurface(cairo.Format.A1, geo.width, geo.height)
  local cr = cairo.Context(img)

  cr:set_operator(cairo.Operator.CLEAR)
  cr:set_source_rgba(0,0,0,1)
  cr:paint()
  cr:set_operator(cairo.Operator.SOURCE)
  cr:set_source_rgba(1,1,1,1)

  shape(cr, geo.width, geo.height, shape_args)

  cr:fill()

  draw.shape_bounding = img._native

  cr:set_operator(cairo.Operator.CLEAR)
  cr:set_source_rgba(0,0,0,1)
  cr:paint()
  cr:set_operator(cairo.Operator.SOURCE)
  cr:set_source_rgba(1,1,1,1)

  local border = beautiful.base_border_width
  --local titlebar_height = titlebar.is_enabled(draw) and beautiful.titlebar_height or border
  local titlebar_height = border
  gears.shape.transform(shape):translate(
    border, titlebar_height
  )(
    cr,
    geo.width-border*2,
    geo.height-titlebar_height-border,
    --shape_args
    8
  )

  cr:fill()

  draw.shape_clip = img._native

  img:finish()
end

client.connect_signal("property::geometry", function (c)
  if not c.fullscreen then
    timer.delayed_call(apply_shape, c, gears.shape.rounded_rect, 10)
  end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- Autostart user applications
-- Run once function
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

 run_once("compton --backend glx --paint-on-overlay --vsync opengl-swc --unredir-if-possible --config ~/.compton.conf")
  run_once("nm-applet")
  run_once("mopidy --config ~/.config/mopidy/mopidy.conf")
  run_once("setxkbmap -option caps:escape")
  run_once("scrl.sh")
  run_once("pulseaudio")
--  run_once("mpd")
  run_once("pasystray")
  run_once("parcellite")
  run_once("dropbox")
  run_once("caffeine")
  run_once("xset -b")
  run_once("unclutter -idle 4")
  run_once("transmission-gtk -m -p 9095")
  run_once("nitrogen --restore")
  run_once("start_conky.sh")
  run_once("source ~.profile")
  -- run_once("insync start")
  run_once("synergys -c ~/.config/Synergy/syn.conf -f --name archlinux")
-- end

--]]
