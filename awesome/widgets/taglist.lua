local gears = require("gears")
local colors  = require("utils.colors")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

function return_taglist(s)
    local unfocus_icon = ""
    local unfocus_color = colors.frost.lightest

    local empty_icon = "ﱤ"
    local empty_color = colors.polar.lighter

    local focus_icon =  "ﱣ"
    local focus_color = colors.light.lightest
----------------------------------------------------------------------
----------------------------------------------------------------------

    -- Function to update the tags
    local update_tags = function(self, c3)
        local tagicon = self:get_children_by_id('icon_role')[1]
        local isurgent = false
        if c3.selected then
            tagicon.text = focus_icon
            self.fg = focus_color
        elseif #c3:clients() == 0 then
            tagicon.text = empty_icon
            self.fg = empty_color
        elseif c3.urgent then
            tagicon.text = ""
            self.fg = colors.yellow
        else
            if isurgent == false then
                tagicon.text = unfocus_icon
                self.fg = unfocus_color 
            end
        end

        c3:connect_signal("property::urgent",
        function()
            isurgent = true
            tagicon.text = ""
            self.fg = colors.yellow
        end
        ) 

        
    end
    
----------------------------------------------------------------------
----------------------------------------------------------------------

    local icon_taglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        layout = {spacing = 0, layout = wibox.layout.fixed.horizontal},
        widget_template = {
            {
                {id = 'icon_role', font = "JetBrainsMono Nerd Font 16", widget = wibox.widget.textbox},
                id = 'margin_role',
                top = dpi(0),
                bottom = dpi(0),
                left = dpi(2),
                right = dpi(2),
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background,
            create_callback = function(self, c3, index, objects)
                update_tags(self, c3)
                local tagicon = self:get_children_by_id('icon_role')[1]
            end,

            update_callback = function(self, c3, index, objects)
                update_tags(self, c3)
            end
        },
        buttons = awful.util.taglist_buttons
    }

    local taglist = wibox.widget{
      {
            {
                
                {
                    
                    {
                        forced_width  = 8,
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
                    
                    icon_taglist,
                    left = 7,
                    right = 7,
                    widget = wibox.container.margin
                },
                {
                    
                    {
                        forced_width  = 8,
                        forced_height = 30,
                        thickness     = 10,
                        color         = colors.green,
                        widget        = wibox.widget.separator
                    },
                    valign = 'left',
                    halign = 'left',
                    widget = wibox.container.place,
                    
                },
                layout = wibox.layout.fixed.horizontal
                
            },
            shape = gears.shape.rectangle,
            shape_border_width = 5,
            shape_border_color = colors.polar.darkest.."00"
            ,
            bg = colors.polar.darkest .. 'ac',
            widget = wibox.container.background     
      },
      margins = 1,
      widget = wibox.container.margin
  }

  return taglist
end

return return_taglist
