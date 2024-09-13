#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
  xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
  xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
  xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
  xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [ -x "$f" ] && . "$f"
  done
  unset f
else
  dbus-update-activation-environment DISPLAY XAUTHORITY WAYLAND_DISPLAY
fi

export _JAVA_AWT_WM_NONREPARENTING=1

run() {
  bin=$(whereis $1 | awk '{print $2}')
  if [ ! -z $bin ] && [ -x $bin ]; then
    pidof $1 && kill -9 $(pidof $1)
    eval $bin
  fi
}

run pipewire &
sleep .5
run xdg-desktop-portal &
sleep .5
run xdg-desktop-portal-gtk &
run polkit-gnome-authentication-agent-1 &
run dunst &
~/.fehbg &

exec dbus-run-session bspwm
