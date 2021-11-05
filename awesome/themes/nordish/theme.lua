--[[
Config files by MrJakeSir
--]]

local gears = require("gears")
local add_app = require("utils.add_app")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi
local widgets = require('widgets')

local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

-- Constants
TERMINAL                                        = "kitty"
--BROWSER                                         = "chromium"


--local colors = require("util.colors").colors

-- Nord theme colorscheme
local colors                                      = require("utils.colors")

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/nordish"

-- Sets up the wallpaper 
theme.wallpaper                                 = theme.dir .. "/wallpaper.jpg"

-- Font
theme.font                                      = "Roboto 12"
theme.taglist_font                              = "JetBrainsMono Nerd Font 13"

-- Gaps between windows
-- Otherwise you can change them by using:
--      altkey + ctrl + j           = Increment gaps
--      altkey + ctrl + h           = Decrement gaps
theme.useless_gap                               = 0

--  Foreground variables  --
theme.fg_normal                                 = "#ffffff" -- White
theme.fg_focus                                  = colors.green
theme.fg_urgent                                 = "#000000" -- Black
--  Background variables  --
theme.bg_normal                                 = colors.bg
theme.bg_focus                                  = theme.bg_normal
theme.bg_urgent                                 = colors.red

-- Systray background color
theme.bg_systray                	        = colors.polar.darkest.. '00'

-- Systray icon spacing 
theme.systray_icon_spacing		        = 5

-- Taglist configuration --
theme.taglist_bg_occupied                       = colors.polar.darkest .. '00'
theme.taglist_fg_occupied                       = colors.yellow        
theme.taglist_bg_empty                          = colors.polar.darkest .. '00'
theme.taglist_fg_empty                          = colors.green         
theme.taglist_bg_urgent                         = colors.polar.darkest .. '00'
theme.taglist_fg_urgent                         = colors.pink         
theme.taglist_fg_volatile                       = colors.frost.lightest
theme.taglist_bg_volatile                       = colors.polar.darkest .. '00'
-- Colors
theme.taglist_fg_focus                          = colors.light.medium
theme.taglist_bg_focus                          = colors.polar.darkest .. '00'
-- Taglist shape, refer to awesome wm documentation if you have 
-- any doubt about this!
theme.taglist_shape                             = gears.shape.rectangle

-- Icon spacing between workspace icons 
theme.taglist_spacing				= 0

-- Sets the border to zero
theme.border_width                              = 5

-- If the border is not zero, it'll show 
-- These colors 
theme.border_normal                             = colors.polar.lightest 
theme.border_focus                              = colors.polar.lightest
theme.border_marked                             = colors.polar.lightest

-- Titlebar variables, dont care about theme,
-- In this configuration file we wont use it!
theme.titlebar_bg_focus                         = "#3F3F3F"
theme.titlebar_bg_normal                        = "#3F3F3F"
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus


theme.layout_fairh                       = "/usr/share/awesome/themes/zenburn/layouts/fairh.png"
theme.layout_fairv                       = "/usr/share/awesome/themes/zenburn/layouts/fairv.png"
theme.layout_floating                    = "/usr/share/awesome/themes/zenburn/layouts/floating.png"
theme.layout_magnifier                   = "/usr/share/awesome/themes/zenburn/layouts/magnifier.png"
theme.layout_max                         = "/usr/share/awesome/themes/zenburn/layouts/max.png"
theme.layout_fullscreen                  = "/usr/share/awesome/themes/zenburn/layouts/fullscreen.png"
theme.layout_tilebottom                  = "/usr/share/awesome/themes/zenburn/layouts/tilebottom.png"
theme.layout_tileleft                    = "/usr/share/awesome/themes/zenburn/layouts/tileleft.png"
theme.layout_tile                        = "/usr/share/awesome/themes/zenburn/layouts/tile.png"
theme.layout_tiletop                     = "/usr/share/awesome/themes/zenburn/layouts/tiletop.png"
theme.layout_spiral                      = "/usr/share/awesome/themes/zenburn/layouts/spiral.png"
theme.layout_dwindle                     = "/usr/share/awesome/themes/zenburn/layouts/dwindle.png"
theme.layout_cornernw                    = "/usr/share/awesome/themes/zenburn/layouts/cornernw.png"
theme.layout_cornerne                    = "/usr/share/awesome/themes/zenburn/layouts/cornerne.png"
theme.layout_cornersw                    = "/usr/share/awesome/themes/zenburn/layouts/cornersw.png"
theme.layout_cornerse                    = "/usr/share/awesome/themes/zenburn/layouts/cornerse.png"

-- Menu variables
theme.menu_height                               = dpi(25)
theme.menu_width                                = dpi(260)

local clock = wibox.widget{
  {
    markup = '<span foreground="'..colors.yellow..'a1'..'"></span>',
    font = 'JetBrainsMono Nerd Font 15',
    widget = wibox.widget.textbox
  },
  wibox.container.margin(nil, 4, 4, 0, 0),
  {
    format = "%H:%M",
    widget = wibox.widget.textclock
  },
  layout = wibox.layout.fixed.horizontal
}

function theme.at_screen_connect(s)
    
    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end

    gears.wallpaper.maximized(wallpaper, s, true)

    -- All tags open with layout 1
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = widgets.prompt(s)
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = widgets.layouts(s)
    s.mylayoutbox:buttons(my_table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    
    s.mytasklist = widgets.tasklist(s, tasklist_buttons)
    -- Custom rounded background widget
    -- You can modify however you want
    -- Syntax:
    --  round_bg_widget(widget, background_colour, foreground)
    function round_bg_widget(widget, bg, fg)
        local widget = wibox.widget {
          
          {
              
              -- Set up 
              {
                  {
                  
                      {
                          forced_width  = 8,
                          forced_height = 40,
                          thickness     = 10,
                          color         = fg,
                          widget        = wibox.widget.separator
                      },
                      valign = 'left',
                      halign = 'left',
                      widget = wibox.container.place,
                      
                  },
                  {
                      widget,
                      left = 7,
                      right = 7,
                      top = 2,
                      bottom = 2,
                      widget = wibox.container.margin
                  },
                  nil,
                  --{
                  --
                  --    {
                  --        forced_width  = 8,
                  --        forced_height = 25,
                  --        thickness     = 10,
                  --        color         = fg,
                  --        widget        = wibox.widget.separator
                  --    },
                  --    valign = 'left',
                  --    halign = 'left',
                  --    widget = wibox.container.place,
                  --    
                  --},
                  layout = wibox.layout.fixed.horizontal
              },
              bg         = bg .. 'ac',
              fg         = fg,
              widget     = wibox.container.background,
          },
          margins = 4,
          widget = wibox.container.margin
        }
		
		return widget
    end
    -- The function ends
    
    
    ---------- Simple widget separator ----------
    local sep   = wibox.widget.textbox("  ")
    
    ---------- If you want to change the size of the spacing,
    --         change the font size, instead of 5. Just play with it!
    sep.font    = "JetBrainsMono Nerd Font 10"

    local appsep= wibox.widget.textbox("  ")
    appsep.font = "JetBrainsMono Nerd Font 5"
    local systray = wibox.widget.systray() 
    
    local systray = wibox.widget{
          
          {
              
              -- Set up 
              {
                  {
                  
                      {
                          forced_width  = 8,
                          forced_height = 40,
                          thickness     = 10,
                          color         = colors.red,
                          widget        = wibox.widget.separator
                      },
                      valign = 'left',
                      halign = 'left',
                      widget = wibox.container.place,
                      
                  },
                  add_app(
                      function()
                          awful.screen.focused(
                          ).systray.visible = not awful.screen.focused(
                          ).systray.visible
                      end,
                      "",
                      colors.red,
                      colors.polar.darkest
                  ),
                  {
                    {
                       systray,
                       nil,
                       layout = wibox.layout.fixed.horizontal
                    },
                    margins = 4,
                    widget = wibox.container.margin
                  },
                  --{
                  --
                  --    {
                  --        forced_width  = 8,
                  --        forced_height = 25,
                  --        thickness     = 10,
                  --        color         = fg,
                  --        widget        = wibox.widget.separator
                  --    },
                  --    valign = 'left',
                  --    halign = 'left',
                  --    widget = wibox.container.place,
                  --    
                  --},
                  layout = wibox.layout.fixed.horizontal
              },
              bg         = colors.polar.darkest .. 'ac',
              fg         = fg,
              widget     = wibox.container.background,
          },
          margins = 4,
          widget = wibox.container.margin
        }

    
    -- Creates the wibox 
    s.mywibox = awful.wibar(
      { 
        position = "top",
        screen = s, 
        width = dpi(s.workarea.width-40-theme.border_width-7),
        height = dpi(40),
        bg = theme.bg_normal,
        fg = theme.fg_normal,
        border_width = 5,
        border_color = colors.polar.lightest,
      }
    )

    local time = round_bg_widget(wibox.container.margin(clock,
               dpi(4),
               dpi(8)),
               colors.polar.darkest,
               colors.yellow
            )
    
    
    local time = widgets.calendar(time)
    s.mywibox.y = 10
    
---------------------------------------
--                                    --
--            Widget setup            --
--                                    --
----------------------------------------
    
    s.mywibox:setup {
        {
            layout = wibox.layout.align.horizontal,
            expand='none',

            { -- Left widgets
                appsep,
                widgets.menu(s), appsep, appsep, appsep,
                s.mypromptbox,
                -- Workspaces
            
                widgets.taglist(s),
                    
                
                layout = wibox.layout.fixed.horizontal,    

                
            },
            { -- center widgets
                layout = wibox.layout.fixed.horizontal,
                s.mytasklist
            },
            
           -- { -- center widgets
           --     layout = wibox.layout.fixed.horizontal,
           --     wibox.widget.textbox("")
           -- },

            {
              -- right widgets
              layout = wibox.layout.fixed.horizontal,
              appsep,
              time,
              appsep,
              widgets.volume,
              appsep,
              systray,
              appsep,
              add_app(
                  function()
                    awful.spawn.with_shell(TERMINAL .." -e nmtui")
                  end,
                  "",
                  colors.yellow,
                  colors.polar.darkest
              ),
              appsep,
              add_app(
                  function()
                    awful.spawn.with_shell(TERMINAL .." -e htop")
                  end,
                  "",
                  colors.green,
                  colors.polar.darkest
              ),
              
              awful.widget.layoutbox(s)
                  
              
              --notif(s)
            }

        },
        top = 1,
        bottom = 1,
        widget = wibox.container.margin
    }
    awful.screen.padding(screen[s], {top = 25, left = 20,
                                    right = 20, bottom = 10})
end

-- Returns the theme 
return theme
