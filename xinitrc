#!/bin/sh

export _JAVA_AWT_WM_NONREPARENTING=1

systemctl --user import-environment DISPLAY XAUTHORITY

if command -v dbus-update-activation-environment >/dev/null 2>&1; then
  #dbus-update-activation-environment DISPLAY XAUTHORITY
  dbus-update-activation-environment --all
fi

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xdg-desktop-portal &
/usr/bin/dunst &
~/.fehbg &

exec bspwm
