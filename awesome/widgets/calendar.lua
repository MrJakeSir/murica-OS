local gears                                       = require("gears")
local colors                                      = require("utils.colors")
local awful                                       = require("awful")
local wibox                                       = require("wibox")
local dpi                                         = require("beautiful.xresources").apply_dpi

function calendar(widget)
      local popup = awful.popup {
          widget = {
            {
              {
                text = "── Calendar ──",
                align="center",
                widget = wibox.widget.textbox
              },
              widget = wibox.container.background
            },
            {
              {
                {
                  text = "",
                  align = "center",
                  font = "JetBrainsMono Nerd Font 60",
                  widget = wibox.widget.textbox
                },
                right = 20,
                left = 30,
                widget = wibox.container.margin
              },
              {
                {
                  {
                    
                    {
                      {
                        text = "Today is a great day!",
                        widget = wibox.widget.textbox
                      },
                      {
                        {
                          {
                            text = "",
                            widget = wibox.widget.textbox
                          },
                          fg = colors.red,
                          widget = wibox.container.background,
                        },
                        {
                          format = " %B",
                          refresh = 60,
                          widget = wibox.widget.textclock
                        },
                        margins = 5,
                        widget = wibox.container.margin,
                        layout = wibox.layout.fixed.horizontal
                      },
                     {
                        {
                          {
                            text = "",
                            widget = wibox.widget.textbox
                          },
                          fg = colors.green,
                          widget = wibox.container.background,
                        },
                        {
                          format = " %d",
                          refresh = 60,
                          widget = wibox.widget.textclock
                        },
                        margins = 5,
                        widget = wibox.container.margin,
                        layout = wibox.layout.fixed.horizontal
                      },
                     {
                        {
                          {
                            text = "",
                            widget = wibox.widget.textbox
                          },
                          fg = colors.pink,
                          widget = wibox.container.background,
                        },
                        {
                          format = " %Y",
                          refresh = 60,
                          widget = wibox.widget.textclock
                        },
                        margins = 5,
                        widget = wibox.container.margin,
                        layout = wibox.layout.fixed.horizontal
                      },
                      {
                        {
                          {
                            text = "",
                            widget = wibox.widget.textbox
                          },
                          fg = colors.yellow,
                          widget = wibox.container.background,
                        },
                        {
                          format = " %A",
                          refresh = 60,
                          widget = wibox.widget.textclock
                        },
                        margins = 5,
                        widget = wibox.container.margin,
                        layout = wibox.layout.fixed.horizontal
                      },
                      {
                        {
                          {
                            text = "",
                            widget = wibox.widget.textbox
                          },
                          fg = colors.frost.lightest,
                          widget = wibox.container.background,
                        },
                        {
                          format = " %H:%M%p ",
                          refresh = 60,
                          widget = wibox.widget.textclock
                        },
                        margins = 5,
                        widget = wibox.container.margin,
                        layout = wibox.layout.fixed.horizontal
                      },                    
                      expand = 'none',
                      widget = wibox.container.background,
                      layout = wibox.layout.fixed.vertical
                    },

                    margins = 10,
                    widget = wibox.container.margin,
                  },

                  bg = colors.polar.darkest.."5a",
                  shape = gears.shape.rounded_rect,
                  widget = wibox.container.background
                },
                margins = 10,
                widget = wibox.container.margin
              },
              layout = wibox.layout.fixed.horizontal,

            },
            layout = wibox.layout.fixed.vertical,
            widget = wibox.container.margin
          },
          bg = colors.bg,
          fg = "#ffffff",
          ontop=true,
          border_width = 5,
          border_color = colors.polar.lightest,
          visible      = false,
      }
      widget:connect_signal("button::press",
        function()
          if popup.visible then
            popup.visible = false
          else
            popup:move_next_to(mouse.current_widget_geometry)
            popup.y = 75
            popup.visible = true
          end
        end
      )


      return widget
    end
return calendar
