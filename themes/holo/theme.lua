
--[[
                                
     Holo Awesome WM config 2.0 
     github.com/copycat-killer  
                                
--]]

theme                                = {}

-- Panel widgets
-----------------------------------------------------------------------------------------------------------------------
theme.widget = {}

-- Widgets placement
--------------------------------------------------------------------------------
theme.widget.margin = {
	single_sep  = { 0, 0, 3, 3 },
	taglist     = { 8, 8, 0, 0 },
	sysmon      = { 8, 8, 0, 0 },
	tasklist    = { 0, 3, 0, 3 },
	kbindicator = { 12, 12, 4, 4 },
	net         = { 6, 6, 6, 6 },
	volume      = { 12, 12, 5, 5 },
	mail        = { 12, 12, 4, 4 },
	layoutbox   = { 12, 12, 6, 6 },
	tray        = { 12, 12, 7, 7 },
	textclock   = { 12, 12, 0, 0 }
}

theme.icon_dir                       = os.getenv("HOME") .. "/.config/awesome/themes/holo/icons"
theme.path                                 = os.getenv("HOME") .. "/.config/awesome/themes/holo/"
theme.wallpaper                      = os.getenv("HOME") .. "/.config/awesome/themes/holo/wall.png"
theme.material                      = os.getenv("HOME") .. "/.config/awesome/themes/holo/material-design-icons/"

theme.topbar_path                    = "png:" .. theme.icon_dir .. "/topbar/"

theme.font                           = "Roboto Mono for Powerline 10.5"
theme.taglist_font                   = "Ume Hy Gothic 14"
theme.fg_normal                      = "#FFFFFF"
theme.fg_focus                       = "#0099CC"
theme.bg_normal                      = "#546E7A"
theme.fg_urgent                      = "#CC9393"
theme.bg_urgent                      = "#2A1F1E"
theme.border_width                   = "3"
theme.border_normal                  = "#D32F2F"
theme.border_focus                   = "#388E3C"
theme.taglist_fg_focus               = "#000000"
-- theme.taglist_bg_focus               = "png:" .. theme.icon_dir .. "/taglist_bg_focus.png"
theme.taglist_bg_focus               = "#546E7A"
theme.tasklist_bg_normal             = "#222222"
theme.tasklist_fg_focus              = "#4CB7DB"
theme.tasklist_bg_focus              = "png:" .. theme.icon_dir .. "/bg_focus_noline.png"
theme.textbox_widget_margin_top      = 1
theme.awful_widget_height            = 32
theme.awful_widget_margin_top        = 2
theme.menu_height                    = "20"
theme.menu_width                     = "400"

theme.widget_bg                      = "#424242"
theme.awesome_icon                   = theme.icon_dir .. "/awesome_icon.png"
theme.vol_bg                         = theme.icon_dir .. "/vol_bg.png"
theme.vol                           = theme.material .. "av/1x_web/ic_volume_up_white_48dp.png"
theme.menu_submenu_icon              = theme.icon_dir .. "/submenu.png"
theme.taglist_squares_sel            = theme.icon_dir .. "/square_sel.png"
theme.taglist_squares_unsel          = theme.icon_dir .. "/square_unsel.png"
theme.last                           = theme.icon_dir .. "/last.png"
theme.spr                            = theme.icon_dir .. "/spr.png"
theme.spr_small                      = theme.icon_dir .. "/spr_small.png"
theme.spr_very_small                 = theme.icon_dir .. "/spr_very_small.png"
theme.spr_right                      = theme.icon_dir .. "/spr_right.png"
theme.spr_bottom_right               = theme.icon_dir .. "/spr_bottom_right.png"
theme.spr_left                       = theme.icon_dir .. "/spr_left.png"
theme.bar                            = theme.icon_dir .. "/bar.png"
theme.bat                            = theme.icon_dir .. "/battery.png"
theme.mem                            = theme.icon_dir .. "/mem.png"
theme.cpu                            = theme.icon_dir .. "/cpu.png"
theme.bottom_bar                     = theme.icon_dir .. "/bottom_bar.png"
theme.mpd                           = theme.path .. "/music.png"
theme.mpd_on                         = theme.icon_dir .. "/mpd_on.png"
theme.prev                           = theme.path .. "/backward.png"
theme.nex                           = theme.path .. "/forward.png"
theme.stop                           = theme.material .. "av/1x_web/ic_stop_black_48dp.png"
theme.pause                           = theme.path .. "/pause.png"
theme.play                           = theme.path .. "/play.png"
theme.clock                          = theme.icon_dir .. "/clock.png"
theme.calendar                       = theme.icon_dir .. "/cal.png"
theme.cpu                            = theme.icon_dir .. "/cpu.png"
theme.net_up                         = theme.icon_dir .. "/net_up.png"
theme.net_down                       = theme.icon_dir .. "/net_down.png"
theme.widget_mail_notify             = theme.icon_dir .. "/mail_notify.png"

-- You can use your own layout icons like this:
theme.layout_fairh = "/usr/share/awesome/themes/default/layouts/fairhw.png"
theme.layout_fairv = "/usr/share/awesome/themes/default/layouts/fairvw.png"
theme.layout_floating  = "/usr/share/awesome/themes/default/layouts/floatingw.png"
theme.layout_magnifier = "/usr/share/awesome/themes/default/layouts/magnifierw.png"
theme.layout_max = "/usr/share/awesome/themes/default/layouts/maxw.png"
theme.layout_fullscreen = "/usr/share/awesome/themes/default/layouts/fullscreenw.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/default/layouts/tilebottomw.png"
theme.layout_tileleft   = "/usr/share/awesome/themes/default/layouts/tileleftw.png"
theme.layout_tile = "/usr/share/awesome/themes/default/layouts/tilew.png"
theme.layout_tiletop = "/usr/share/awesome/themes/default/layouts/tiletopw.png"
theme.layout_spiral  = "/usr/share/awesome/themes/default/layouts/spiralw.png"
theme.layout_dwindle = "/usr/share/awesome/themes/default/layouts/dwindlew.png"
theme.layout_cornernw = "/usr/share/awesome/themes/default/layouts/cornernww.png"
theme.layout_cornerne = "/usr/share/awesome/themes/default/layouts/cornernew.png"
theme.layout_cornersw = "/usr/share/awesome/themes/default/layouts/cornersww.png"
theme.layout_cornerse = "/usr/share/awesome/themes/default/layouts/cornersew.png"


theme.titlebar_close_button_normal = "/usr/share/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = "/usr/share/awesome/themes/default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = "/usr/share/awesome/themes/default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"

theme.useless_gap   = 8
theme.tasklist_disable_icon          = true
theme.tasklist_floating              = ""
theme.tasklist_maximized_horizontal  = ""
theme.tasklist_maximized_vertical    = ""




return theme
