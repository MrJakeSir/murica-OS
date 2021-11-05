-- Modules
local gears = require("gears")
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local colors = require("utils.colors")
local add_app = require("utils.add_app")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi   = require("beautiful.xresources").apply_dpi

local volume_widget_container = wibox.widget {
    {
        {
            {
            
                {
                    forced_width  = 8,
                    forced_height = 40,
                    thickness     = 10,
                    color         = colors.pink,
                    widget        = wibox.widget.separator
                },
                valign = 'left',
                halign = 'left',
                widget = wibox.container.place,
                
            },
            {
                {
                     
                    layout=wibox.layout.fixed.horizontal,
                    {
                        {
                            text="",
                            font="JetBrainsMono Nerd Font 15",
                            widget=wibox.widget.textbox
                        },
                        fg = colors.light.medium,
                        widget = wibox.container.background,
                    },
                    volume_widget{
                        main_color=colors.pink,
                        widget_type = 'horizontal_bar',
                        width = 50,
                        bg_color=colors.polar.lighter
                    },
                },
                left = 7,
                right = 7,
                widget = wibox.container.margin
            },
            nil,
            layout = wibox.layout.fixed.horizontal
        },
        bg = colors.polar.darkest .. 'ac',
        widget = wibox.container.background
    },
    margins = 4,
    widget = wibox.container.margin
}
local volume_up = add_app(
  function()
    volume_widget:inc()
  end,
  "",
  colors.yellow,
  colors.polar.darkest,
  "Increase volume"
)

local volume_down = add_app(
  function()
    volume_widget:dec()
  end,
  "墳",
  colors.yellow,
  colors.polar.darkest,
  "Decrease volume"
)

local volume_toggle = add_app(
  function()
    volume_widget:toggle()
  end,
  "婢",
  colors.yellow,
  colors.polar.darkest,
  "Toggle volume"
)



local separator = wibox.widget{
  text = " ",
  font = "JetBrainsMono Nerd Font 15",
  widget = wibox.widget.textbox
}

local popup = awful.popup{
  widget = {
    {
      {
        {
          {
            text = "Volume\nControl",
            font = "JetBrainsMono Nerd Font 10",
            align = "center",
            widget = wibox.widget.textbox
          },
          margins = 5,
          widget = wibox.container.margin
        },
        {
          {
            volume_up,
            separator,
            volume_down,
            separator, 
            volume_toggle,
            layout = wibox.layout.fixed.vertical
          },
          margins = 20,
          top = 5,       
          widget = wibox.container.margin
        },
        layout = wibox.layout.align.vertical,
      },
      bg = colors.bg,
      widget = wibox.container.background
    },
    margins = 5,
    widget = wibox.container.margin 
  },
  bg           = colors.polar.lightest,
  fg           = colors.light.lighter,
  ontop        = true,
  visible      = false,
}

volume_widget_container:connect_signal("button::press", function()
  if popup.visible then
      popup.visible = false
  else
    popup:move_next_to(mouse.current_widget_geometry)
    popup.y = 75
    popup.visible = true
  end
end)

return volume_widget_container
