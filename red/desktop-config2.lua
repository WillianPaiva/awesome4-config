-----------------------------------------------------------------------------------------------------------------------
--                                               Desktop widgets config                                              --
-----------------------------------------------------------------------------------------------------------------------

-- Grab environment
local beautiful = require("beautiful")
local awful = require("awful")
local redflat = require("redflat")
local io = io
-- Initialize tables and vars for module
-----------------------------------------------------------------------------------------------------------------------
local desktop = {}

-- desktop aliases
local wgeometry = redflat.util.desktop.wgeometry
local workarea = screen[mouse.screen].workarea
local system = redflat.system

-- Desktop widgets
-----------------------------------------------------------------------------------------------------------------------
function desktop:init(args)
  local args = args or {}
	local theme_path = args.tpath or "/usr/share/awesome/themes/default"

  -- placement
	local grid = beautiful.desktop.grid2
	local places = beautiful.desktop.places

	-- Network speed
	--------------------------------------------------------------------------------
	local netspeed = { geometry = wgeometry(grid, places.netspeed, workarea) }

  local inter = "eno1"

  file = io.open("/sys/class/net/eno1/carrier","r")

  io.input(file)
  local state = tonumber(io.read())
  if state ~= 1 then
    inter = "wlp3s0"
  end
  io.close(file)

	netspeed.args = {
    interface    = inter,
		maxspeed     = { up = 5*1024^2, down = 5*1024^2 },
		crit         = { up = 5*1024^2, down = 5*1024^2 },
		timeout      = 2,
		autoscale    = true
	}

	netspeed.style  = {}

	-- SSD speed
	--------------------------------------------------------------------------------
	local ssdspeed = { geometry = wgeometry(grid, places.ssdspeed, workarea) }

	ssdspeed.args = {
		interface = "sda",
		meter_function = system.disk_speed,
		timeout   = 2,
		label     = "ROOT"
	}

	ssdspeed.style = { unit = { { "B", -1 }, { "KB", 2 }, { "MB", 2048 } } }

	-- HDD speed
	--------------------------------------------------------------------------------
	local hddspeed = { geometry = wgeometry(grid, places.hddspeed, workarea) }

	hddspeed.args = {
		interface = "sdc",
		meter_function = system.disk_speed,
		timeout = 2,
		label = "HOME"
	}

	hddspeed.style = awful.util.table.clone(ssdspeed.style)

	-- CPU and memory usage
	--------------------------------------------------------------------------------
	local cpu_storage = { cpu_total = {}, cpu_active = {} }
	local cpumem = { geometry = wgeometry(grid, places.cpumem, workarea) }

	cpumem.args = {
		corners = { num = 8, maxm = 100, crit = 90 },
		lines   = { { maxm = 100, crit = 80 }, { maxm = 100, crit = 80 } },
		meter   = { args = cpu_storage },
		timeout = 2
	}

	cpumem.style = {}

	-- Transmission info
	--------------------------------------------------------------------------------
	local transm = { geometry = wgeometry(grid, places.transm, workarea) }

	transm.args = {
		corners    = { num = 8, maxm = 100 },
		lines      = { { maxm = 55, unit = { { "SEED", - 1 } } }, { maxm = 600, unit = { { "DNLD", - 1 } } } },
		meter      = { func = system.transmission_parse },
		timeout    = 5,
		asyncshell = "transmission-remote 127.0.0.1:9095 -l"
	}

	transm.style = {
		digit_num = 1,
    image     = theme_path .. "/desktop/Pirates.svg"
	}

	-- Disks
	--------------------------------------------------------------------------------
	local disks = { geometry = wgeometry(grid, places.disks, workarea) }

	disks.args = {
		sensors  = {
			{ meter_function = system.fs_info, maxm = 100, crit = 80, args = "/" },
			{ meter_function = system.fs_info, maxm = 100, crit = 80, args = "/home" },
    },
    names   = {"root", "home" },
		timeout = 300
	}

	disks.style = {
		unit      = { { "KB", 1 }, { "MB", 1024^1 }, { "GB", 1024^2 } },
		show_text = false
	}

	-- Temperature indicator
	--------------------------------------------------------------------------------
	local thermal = { geometry = wgeometry(grid, places.thermal, workarea) }

  thermal.args = {
    sensors = {
      { meter_function = system.thermal.sensors_core, args = {index = 0, main = true}, maxm = 100, crit = 75 },
      { meter_function = system.thermal.sensors_core, args = {index = 1}, maxm = 100, crit = 75 },
      { meter_function = system.thermal.sensors_core, args = {index = 2}, maxm = 100, crit = 75 },
      { meter_function = system.thermal.sensors_core, args = {index = 3}, maxm = 100, crit = 75 },
      { meter_function = system.thermal.nvoptimus, maxm = 105, crit = 80 }
    },
    names   = {"core1","core2","core3","core4","gpu"},
    timeout = 5
  }
  thermal.style = {
		unit      = { { "°C", -1 } },
		show_text = true
	}

	-- Initialize all desktop widgets
	--------------------------------------------------------------------------------
	netspeed.widget = redflat.desktop.speedgraph(netspeed.args, netspeed.geometry, netspeed.style)
	ssdspeed.widget = redflat.desktop.speedgraph(ssdspeed.args, ssdspeed.geometry, ssdspeed.style)
	hddspeed.widget = redflat.desktop.speedgraph(hddspeed.args, hddspeed.geometry, hddspeed.style)

	cpumem.widget = redflat.desktop.multim(cpumem.args, cpumem.geometry, cpumem.style)
	transm.widget = redflat.desktop.multim(transm.args, transm.geometry, transm.style)

	disks.widget   = redflat.desktop.dashpack(disks.args, disks.geometry, disks.style)
	thermal.widget = redflat.desktop.dashpack(thermal.args, thermal.geometry, thermal.style)
end

-- End
-----------------------------------------------------------------------------------------------------------------------
return desktop
