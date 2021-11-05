local awful = require('awful')

return {
  menu = require("widgets.menu"),
  taglist = require("widgets.taglist"),
  tasklist = require("widgets.tasklist"),
  volume = require("widgets.volumewidget"),
  calendar = require("widgets.calendar"),
  layouts = function(s) return awful.widget.layoutbox(s) end,
  prompt = function(s) return awful.widget.prompt(s) end,
}
