local gears = require("gears")
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local add_app = require("utils.add_app")
local colors = require("utils.colors")
local awful = require("awful")
local wibox = require("wibox")
--local notif = require('widget.notif-center')
local dpi   = require("beautiful.xresources").apply_dpi

local tasklist = function(s, tasklist_buttons)
  local tasks = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = tasklist_buttons,
        layout   = {
            spacing_widget = {
                {
                    forced_width  = 10,
                    forced_height = 40,
                    thickness     = 4,
                    color         = '#77777700',
                    widget        = wibox.widget.separator
                },
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place,
            },
            spacing = 5,
            layout  = wibox.layout.fixed.horizontal
        },
        -- Notice that there is *NO* wibox.wibox prefix, it is a template,
        -- not a widget instance.
        widget_template = {
            {
                wibox.widget.base.make_widget(),
                --forced_height = 2,
                id            = 'background_role',
                widget        = wibox.container.background,
            },
            {
                {
                  
                    {
                        forced_width  = 5,
                        forced_height = 30,
                        thickness     = 10,
                        color         = colors.green,
                        widget        = wibox.widget.separator
                    },
                    valign = 'left',
                    halign = 'left',
                    widget = wibox.container.place,
                    
                },
                {
                  {
                      {
                          {
                            id     = 'clienticon',
                            widget = awful.widget.clienticon,
                          },
                          margins = 4,
                          widget = wibox.container.margin,
                      },
                      shape = gears.shape.rectangle,
                      shape_clip = true,
                      shape_border_width = 3,
                      shape_border_color = colors.polar.darkest .. "bf",
                      bg = colors.polar.darkest .. "ac",
                      widget  = wibox.container.background
                  },
                  margins = 3,
                  left = 0,
                  widget = wibox.container.margin
                },
                nil,
                layout = wibox.layout.fixed.horizontal
            },
            nil,
            create_callback = function(self, c, index, objects) --luacheck: no unused args
                self:get_children_by_id('clienticon')[1].client = c
            end,
            layout = wibox.layout.align.vertical,
        },
    }

    return tasks
end

return tasklist
