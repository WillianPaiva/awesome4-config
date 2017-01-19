-----------------------------------------------------------------------------------------------------------------------
--                                                Rules config                                                       --
-----------------------------------------------------------------------------------------------------------------------

-- Grab environment
local awful =require("awful")

-- Initialize tables and vars for module
-----------------------------------------------------------------------------------------------------------------------
local rules = {}

-- Build rule table
-----------------------------------------------------------------------------------------------------------------------
function rules:build(args)

	local args = args or {}
	local tags = args.tags or {} -- bad !!!

  local user_rules = {
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
      properties = { floating = true , ontop = true }
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
  }


  return user_rules
end

-- End
-----------------------------------------------------------------------------------------------------------------------
return rules
