#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

run xrandr --output LVDS-1 --mode 1366x768 --rotate normal --output VGA-1 --primary --mode 1920x1080 --rotate normal --right-of LVDS-1
run nm-applet
run pamac-tray
run variety
run xfce4-power-manager
run blueberry-tray
run picom
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run numlockx on
run volumeicon
run dunst

