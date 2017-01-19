-----------------------------------------------------------------------------------------------------------------------
--                                                  Orange theme                                                     --
-----------------------------------------------------------------------------------------------------------------------

local theme = {}
local wa = screen[mouse.screen].workarea

-- Color scheme
-----------------------------------------------------------------------------------------------------------------------
theme.color = {
	main      = "#B22B00",
	gray      = "#575757",
	bg        = "#161616",
	bg_second = "#181818",
	wibox     = "#202020",
	icon      = "#a0a0a0",
	text      = "#aaaaaa",
	urgent    = "#064A71",
	highlight = "#ffffff",

	border    = "#404040",
	shadow1   = "#141414",
	shadow2   = "#313131",
	shadow3   = "#1c1c1c",
	shadow4   = "#767676"
}

-- colors for defaults widgets
theme.bg_normal     = theme.color.wibox
theme.bg_focus      = theme.color.main
theme.bg_urgent     = theme.color.urgent
theme.bg_minimize   = theme.color.gray

theme.fg_normal     = theme.color.text
theme.fg_focus      = theme.color.highlight
theme.fg_urgent     = theme.color.highlight
theme.fg_minimize   = theme.color.highlight

theme.border_normal = theme.color.wibox
theme.border_focus  = theme.color.wibox
theme.border_marked = theme.color.main


-- Common
-----------------------------------------------------------------------------------------------------------------------
local homedir = os.getenv("HOME")
theme.path = homedir .. "/.config/awesome/themes/orange"

-- Main config
--------------------------------------------------------------------------------

-- fonts
theme.font          = "Play 14"      -- main theme font
theme.font_title    = "Play bold 14" -- title font for widgets
theme.font_titlebar = "Play bold 14" -- title font for windows
theme.font_clock    = "Play bold 12" -- font for textclock widget
theme.font_notify   = "Play bold 16" -- font for notify widget

theme.font_exaile_main = "Play bold 14" -- main font for exaile widget
theme.font_exaile_time = "Play bold 16" -- time status font for exaile widget

theme.font_helper_title = "Play bold 16" -- hotkeys helper title font

-- cairo formated fonts
theme.cf_appswitcher     = { font = "Play", size = 22, face = 1 } -- application switcher font
theme.cf_tag             = { font = "Play", size = 16, face = 1 } -- tag widget font
theme.cf_navigator_title = { font = "Play", size = 28, face = 1, slant = 0 } -- window navigation title font
theme.cf_navigator_main  = { font = "Play", size = 22, face = 1, slant = 0 } -- window navigation font
-- environment vars
theme.panel_height        = 36 -- panel height
theme.border_width        = 4  -- window border width
theme.useless_gap_width   = 8 -- Lain useless gap
theme.global_border_width = 0  -- Lain global border gap

-- grid layout prop
theme.cellnum = { x = 100, y = 62 }

-- Shared icons
--------------------------------------------------------------------------------
theme.icon = {
	check   = theme.path .. "/common/check.svg",
	blank   = theme.path .. "/common/blank.svg",
	warning = theme.path .. "/common/warning.svg",
	awesome = theme.path .. "/awesome.svg",
}

-- Desktop config
-----------------------------------------------------------------------------------------------------------------------
theme.desktop = { common = {} }

theme.wallpaper = theme.path .. "/wallpaper/custom.png"

theme.desktop.color = {
	main  = theme.color.main,
	icon  = theme.color.icon_desktop or "#606060",
	gray  = theme.color.gray_desktop or "#404040",
	wibox = theme.color.bg .. "00"
}

theme.desktop.textset = {
	font  = "Belligerent Madness 22",
	-- font  = "Idolwild 22",
	-- font  = "Palitoon 26",
	spacing = 10,
	color = theme.desktop.color
}

-- Naughty config
-----------------------------------------------------------------------------------------------------------------------
theme.naughty_preset = {}

theme.naughty_preset.normal = {
	timeout      = 5,
	margin       = 12,
	icon_size    = 80,
	font         = theme.font,
	bg           = theme.color.wibox,
	fg           = theme.color.text,
	height       = 102,
	width        = 480,
	border_width = 2,
	border_color = theme.color.wibox
}

theme.naughty_preset.critical = {
	timeout      = 15,
	margin       = 12,
	icon_size    = 80,
	font         = theme.font,
	bg           = theme.color.wibox,
	fg           = theme.color.text,
	border_width = 2,
	border_color = theme.color.main
}

-- Service utils config
-----------------------------------------------------------------------------------------------------------------------
theme.service = {}

theme.service.navigator = {
	border_width = 0,
	gradstep     = 60,
	marksize     = { width = 160, height = 80, r = 20 },
	linegap      = 32,
	titlefont    = cf_navigator_title,
	font         = cf_navigator_main,
	color        = { border = theme.color.main, mark = theme.color.gray, text = theme.color.wibox,
	                 fbg1 = theme.color.main .. "40", fbg2 = theme.color.main .. "20",
	                 bg1  = theme.color.gray .. "40", bg2  = theme.color.gray .. "20" }
}

-- Menu config
-----------------------------------------------------------------------------------------------------------------------
theme.menu = {
	border_width = 4,
	screen_gap   = theme.useless_gap_width + theme.global_border_width,
	height       = 32,
	width        = 300,
	icon_margin  = { 8, 8, 8, 8 },
	ricon_margin = { 9, 9, 9, 9 },
	font         = theme.font,
	submenu_icon = theme.path .. "/common/submenu.svg"
}

theme.menu.color = {
	border       = theme.color.wibox,
	text         = theme.color.text,
	highlight    = theme.color.highlight,
	main         = theme.color.main,
	wibox        = theme.color.wibox,
	submenu_icon = theme.color.icon
}

-- Titlebar
-----------------------------------------------------------------------------------------------------------------------
theme.titlebar = {
	size          = 8,
	position      = "top",
	font          = theme.font_titlebar,
	icon          = { size = 30, gap = 10 },
	border_margin = { 0, 0, 0, 4 },
	--color         = theme.color
	color         = { text = theme.color.text, main = theme.color.main, gray = theme.color.gray,
	                  wibox = theme.color.wibox }
}

-- Gauge style
-----------------------------------------------------------------------------------------------------------------------
theme.gauge = {}

-- Audio
------------------------------------------------------------
theme.gauge.blueaudio = {
	width   = 75,
	dash    = { bar = { num = 5, width = 4 } },
	dmargin = { 10, 0, 2, 2 },
	icon    = theme.path .. "/widget/headphones.svg",
}

theme.gauge.blueaudio.color = {
	icon = theme.color.icon,
	mute = theme.color.urgent
}

-- Progressbar
------------------------------------------------------------
theme.gauge.progressbar = {
	color = theme.color
}

-- Volume controll indicator
------------------------------------------------------------
theme.gauge.dashcontrol = {
	bar   = { width = 5, num = 6 },
	color = theme.color
}

-- Dotcount
------------------------------------------------------------
theme.gauge.dotcount = {
	column_num   = { 3, 5 },  -- { min, max }
	row_num      = 3,
	dot_size     = 5,
	dot_gap_h    = 4,
	color        = theme.color
}

-- Icon indicator
--------------------------------------------------------------
theme.gauge.dubgicon = {
	icon1       = theme.path .. "/widget/down.svg",
	icon2       = theme.path .. "/widget/up.svg",
	is_vertical = true,
	igap        = -6,
	color       = theme.color
}

-- Monitor
--------------------------------------------------------------
theme.gauge.cirmon = {
	width        = 32,
	line_width   = 4,
	iradius      = 5,
	radius       = 11,
	color    = theme.color
}

-- Tag
------------------------------------------------------------
theme.gauge.orangetag = {
	width        = 36,
	line_width   = theme.gauge.cirmon.line_width,
	iradius      = theme.gauge.cirmon.iradius,
	radius       = theme.gauge.cirmon.radius,
	hilight_min  = false,
	color        = theme.color
}

-- Separator
------------------------------------------------------------
theme.gauge.separator = {
	color  = theme.color
}

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

-- Widgets
--------------------------------------------------------------------------------

-- Upgrades
------------------------------------------------------------
theme.widget.upgrades = {
	notify_icon = theme.path .. "/widget/upgrades.svg",
	color       = theme.color
}

-- Pulseaudio volume control
------------------------------------------------------------
theme.widget.pulse = {
	notify_icon = theme.path .. "/widget/audio.svg"
}

-- Mail
------------------------------------------------------------
theme.widget.mail = {
	icon        = theme.path .. "/widget/mail.svg",
	notify_icon = theme.path .. "/widget/mail.svg",
	color       = theme.color,
}

-- Keyboard
------------------------------------------------------------
theme.widget.keyboard = {
	icon         = theme.path .. "/widget/keyboard.svg",
	micon        = theme.icon,
	layout_color = { theme.color.icon, theme.color.main }
}

theme.widget.keyboard.menu = {
	width        = 180,
	color        = { right_icon = theme.color.icon },
	nohide       = true
}

-- Layoutbox
------------------------------------------------------------
theme.widget.layoutbox = {
	micon = theme.icon,
	color = theme.color
}

theme.widget.layoutbox.icon = {
	floating          = theme.path .. "/layouts/floating.svg",
	max               = theme.path .. "/layouts/max.svg",
	fullscreen        = theme.path .. "/layouts/fullscreen.svg",
	uselesstilebottom = theme.path .. "/layouts/tilebottom.svg",
	uselesstileleft   = theme.path .. "/layouts/tileleft.svg",
	uselesstile       = theme.path .. "/layouts/tile.svg",
	uselesstiletop    = theme.path .. "/layouts/tiletop.svg",
	uselessfair       = theme.path .. "/layouts/fair.svg",
	grid              = theme.path .. "/layouts/grid.svg",
	usermap           = theme.path .. "/layouts/map.svg",
	unknown           = theme.path .. "/layouts/unknown.svg",
}

theme.widget.layoutbox.menu = {
	icon_margin = { 9, 12, 9, 9 },
	width       = 260,
	auto_hotkey = true,
	nohide      = false,
	color =     { right_icon = theme.color.icon, left_icon = theme.color.icon }
}

theme.widget.layoutbox.name_alias = {
	floating          = "Floating",
	fullscreen        = "Fullscreen",
	max               = "Maximized",
	grid              = "Grid",
	usermap           = "User Map",
	uselesstile       = "Right Tile",
	uselessfair       = "Fair Tile",
	uselesstileleft   = "Left Tile",
	uselesstiletop    = "Top Tile",
	uselesstilebottom = "Bottom Tile",
}

-- Tasklist
------------------------------------------------------------
local bluetask = {
	width    = 80,
	show_min = true,
	font     = theme.cf_tag,
	point    = { width = 70, height = 3, gap = 27, dx = 5 },
	text_gap = 20,
	color    = theme.color
}

theme.widget.tasklist = {
	width       = 70,
	char_digit  = 5,
	task        = bluetask
}

-- main
theme.widget.tasklist.winmenu = {
	micon          = theme.icon,
	titleline      = { font = theme.font_title, height = 30 },
	menu           = { width = 240, color = { right_icon = theme.color.icon }, ricon_margin = { 9, 9, 9, 9 } },
	tagmenu        = { width = 180, color = { right_icon = theme.color.icon, left_icon = theme.color.icon } },
	state_iconsize = { 18, 18 },
	layout_icon    = theme.widget.layoutbox.icon,
	color          = theme.color
}

-- tasktip
theme.widget.tasklist.tasktip = {
	color = theme.color
}

-- menu
theme.widget.tasklist.winmenu.icon = {
	floating             = theme.path .. "/common/window_control/floating.svg",
	sticky               = theme.path .. "/common/window_control/pin.svg",
	ontop                = theme.path .. "/common/window_control/ontop.svg",
	below                = theme.path .. "/common/window_control/below.svg",
	close                = theme.path .. "/common/window_control/close.svg",
	minimize             = theme.path .. "/common/window_control/minimize.svg",
	maximize             = theme.path .. "/common/window_control/maximize.svg",
	maximized_horizontal = theme.path .. "/common/window_control/maxh.svg",
	maximized_vertical   = theme.path .. "/common/window_control/maxv.svg",
}

-- task aliases
theme.widget.tasklist.appnames = {}
theme.widget.tasklist.appnames["Exaile"              ] = "EXAILE"
theme.widget.tasklist.appnames["Smplayer"            ] = "SMPL"
theme.widget.tasklist.appnames["Firefox"             ] = "FIFOX"
theme.widget.tasklist.appnames["Gnome-terminal"      ] = "GTERM"
theme.widget.tasklist.appnames["Gnome-system-monitor"] = "SYMON"
theme.widget.tasklist.appnames["Gimp-2.8"            ] = "GIMP"
theme.widget.tasklist.appnames["Goldendict"          ] = "GDIC"
theme.widget.tasklist.appnames["Easytag"             ] = "ETAG"
theme.widget.tasklist.appnames["Mcomix"              ] = "COMIX"
theme.widget.tasklist.appnames["Claws-mail"          ] = "CMAIL"
theme.widget.tasklist.appnames["URxvt"               ] = "RXVT"
theme.widget.tasklist.appnames["VirtualBox"          ] = "VBOX"
theme.widget.tasklist.appnames["Keepassx"            ] = "KPASS"

-- Minitray
------------------------------------------------------------
theme.widget.minitray = {
	border_width = 0,
	geometry     = { height = 40 },
	screen_pos   = { { x = 1800, y = 1110 } },
	screen_gap   = theme.useless_gap_width + theme.global_border_width,
	color        = { wibox = theme.color.wibox, border = theme.color.wibox }
}

-- Textclock
------------------------------------------------------------
theme.widget.textclock = {
	font  = theme.font_clock,
	color = { text = theme.color.icon }
}

-- Floating widgets
-----------------------------------------------------------------------------------------------------------------------
theme.float = {}

-- Tooltip
------------------------------------------------------------
theme.float.tooltip = {
	margin       = { 6, 6, 4, 4 },
	timeout      = 0,
	border_width = 2,
	color        = theme.color
}

-- Application runner
------------------------------------------------------------
theme.float.apprunner = {
	itemnum       = 6,
	geometry      = { width = 620, height = 480 },
	border_margin = { 24, 24, 24, 24 },
	icon_margin   = { 8, 16, 0, 0 },
	title_height  = 48,
	prompt_height = 35,
	title_icon    = theme.path .. "/widget/search.svg",
	--icon_style    = { icons = { custom_only = true, scalable_only = true } },
	icon_style    = { wm_name = "awesome" },
	border_width  = 0,
	name_font     = theme.font_title,
	comment_font  = theme.font,
	color         = theme.color
}

-- Quick launcher
------------------------------------------------------------
theme.float.qlaunch = {
	geometry      = { width = 1400, height = 170 },
	border_margin = { 5, 5, 12, 15 },
	border_width  = 0,
	notify_icon   = theme.icon.warning,
	appline       = { iwidth = 140, im = { 5, 5, 0, 0 }, igap = { 0, 0, 5, 15 }, lheight = 25 },
	state         = { gap = 5, radius = 5, size = 10,  height = 14 },
	df_icon       = homedir .. "/.icons/ACYLS/scalable/mimetypes/application-x-executable.svg",
	no_icon       = homedir .. "/.icons/ACYLS/scalable/apps/question.svg",
	label_font    = theme.font_title,
	color         = theme.color,
}

-- Application switcher
------------------------------------------------------------
theme.float.appswitcher = {
	wibox_height   = 240,
	label_height   = 28,
	title_height   = 40,
	icon_size      = 96,
	border_margin  = { 10, 10, 0, 10 },
	preview_margin = { 15, 15, 15, 15 },
	preview_format = 16 / 10,
	title_font     = theme.font_title,
	border_width   = 0,
	update_timeout = 1 / 12,
	font           = theme.cf_appswitcher,
	color          = theme.color
}

-- additional color
theme.float.appswitcher.color.preview_bg = theme.color.main .. "12"

-- hotkeys
theme.float.appswitcher.hotkeys = { "1",   "2",  "3",  "4",  "5",  "6",  "7",  "8",  "9",  "0",
                                    "F1",  "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10",
                                    "F11", "F12" }

-- Hotkeys helper
------------------------------------------------------------
theme.float.hotkeys = {
	geometry      = { width = 1540, height = 1000 },
	border_margin = { 0, 0, 20, 20 },
	sep_margin    = { 19, 29, 10, 10 },
	border_width  = 0,
	colnum        = 2,
	keyf_width    = 300,
	font          = theme.font,
	keysfont      = theme.font_title,
	titlefont     = theme.font_helper_title,
	color         = theme.color
}

-- Exaile music player
------------------------------------------------------------
local exaile_size = { width = 520, height = 150 }
theme.float.exaile = {
	geometry     = exaile_size,
	screen_gap   = theme.useless_gap_width + theme.global_border_width,
	screen_pos   = { { x = 1400, y = wa.y + wa.height - theme.useless_gap_width - exaile_size.height } },
	titlefont    = theme.font_exaile_main,
	artistfont   = theme.font_exaile_main,
	timefont     = theme.font_exaile_time,
	border_width = 0,
	timeout      = 1,
	color        = theme.color
}

theme.float.exaile.icon = {
	cover   = theme.path .. "/widget/music.svg",
	next_tr = theme.path .. "/common/player_control/next.svg",
	prev_tr = theme.path .. "/common/player_control/previous.svg",
	play    = theme.path .. "/common/player_control/play.svg",
	pause   = theme.path .. "/common/player_control/pause.svg"
}

-- Notify
------------------------------------------------------------
local notify_size = { width = 484, height = 106 }
theme.float.notify = {
	geometry     = notify_size,
	screen_gap   = theme.useless_gap_width + theme.global_border_width,
	screen_pos   = {{ x = wa.x + wa.width - notify_size.width - theme.useless_gap_width, y = theme.useless_gap_width }},
	font         = theme.font_notify,
	border_width = 0,
	color        = theme.color
}

-- Brightness control
------------------------------------------------------------
theme.float.brightness = {
	notify_icon = theme.path .. "/widget/brightness.svg"
}

-- Floating prompt
------------------------------------------------------------
theme.float.prompt = {
	border_width = 0,
	color        = theme.color
}

-- Top processes
------------------------------------------------------------
local top_size = { width = 460, height = 400 }
theme.float.top = {
	geometry      = top_size,
	screen_gap    = theme.useless_gap_width + theme.global_border_width,
	screen_pos    = { { x = wa.x + wa.width  - theme.useless_gap_width - top_size.width,
	                    y = wa.y + wa.height - theme.useless_gap_width - top_size.height } },
	border_margin = { 20, 20, 10, 0 },
	button_margin = { 140, 140, 18, 18 },
	title_height  = 40,
	border_width  = 0,
	bottom_height = 70,
	title_font    = theme.font_title,
	color         = theme.color
}

-- Decoration elements
-----------------------------------------------------------------------------------------------------------------------
theme.float.decoration = {}

theme.float.decoration.button = {
	color = theme.color
}

theme.float.decoration.button.color.text = "#cccccc"
theme.float.decoration.button.color.shadow_down = theme.color.gray

theme.float.decoration.field = {
	color = theme.color
}

-- Desktop file parser
-----------------------------------------------------------------------------------------------------------------------
theme.float.dfparser = {}

theme.float.dfparser.desktop_file_dirs = {
	'/usr/share/applications/',
	'/usr/local/share/applications/'
}

theme.float.dfparser.icons = {
	df_icon       = homedir .. "/.icons/ACYLS/scalable/mimetypes/application-x-executable.svg",
	theme         = homedir .. "/.icons/ACYLS",
	custom_only   = false,
	scalable_only = false
}

-----------------------------------------------------------------------------------------------------------------------
return theme
