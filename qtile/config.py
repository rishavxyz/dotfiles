import os
import subprocess

from libqtile import bar, hook, layout, widget
from libqtile.backend import base
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.dgroups import simple_key_binder
from libqtile.lazy import lazy
# from libqtile.utils import guess_terminal

# autostart
@hook.subscribe.startup_once
def autostart():
    subprocess.call([os.path.expanduser('~/.config/qtile/autostart')])


# vars
mod = 'mod1' # mod key
mod_helper2 = 'control'
# theme for the ui
theme = 'dark'

# apps
terminal = 'kitty'
browser = 'falkon'

keys = [
    # move focus with arrow keys
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),

    # move focus with arrow keys
    Key([mod, 'shift'], "h", lazy.layout.shuffle_left()),
    Key([mod, 'shift'], "l", lazy.layout.shuffle_right()),
    Key([mod, 'shift'], "k", lazy.layout.shuffle_up()),
    Key([mod, 'shift'], "j", lazy.layout.shuffle_down()),

    # grow focus window with arrow keys
    Key([mod, 'control'], "h", lazy.layout.grow_left()),
    Key([mod, 'control'], "l", lazy.layout.grow_right()),
    Key([mod, 'control'], "k", lazy.layout.grow_up()),
    Key([mod, 'control'], "j", lazy.layout.grow_down()),

    # window related
    Key([mod], 'q', lazy.window.kill()),
    Key([mod, 'shift'], 'q', lazy.shutdown()),
    Key([mod, 'shift'], 'r', lazy.reload_config()),

    # spawn applications/programs
    Key([mod, 'shift'], 'Return', lazy.spawncmd()),
    Key([mod], 'Return', lazy.spawn(terminal)),
    Key([mod, 'shift'], 'b', lazy.spawn(browser)),
    Key([mod], 'space', lazy.spawn('dmenu_run')),

    # Volume keys
    Key([], 'XF86AudioRaiseVolume', lazy.spawn('amixer -c 1 sset Master 10+')),
    Key([], 'XF86AudioLowerVolume', lazy.spawn('amixer -c 1 sset Master 10-')),
    Key([], 'XF86AudioMute', lazy.spawn('amixer -c 1 sset Master toggle')),

    # Brightness keys
    Key([], 'XF86MonBrightnessUp', lazy.spawn('xbacklight -inc 5+')),
    Key([], 'XF86MonBrightnessDown', lazy.spawn('xbacklight -dec 5-')),
]

### Rose pine theme [url](https://rosepinetheme.com/palette)
def rosytheme(theme):
    dark = {
        'base':'191724',
        'surface':'1f1d2e',
        'muted':'6e6a86',
        'subtle':'908caa',
        'text':'e0def4',
        'love':'eb6f92',
        'gold':'f6c177',
        'rose':'ebbcba',
        'pine':'31748f',
        'foam':'9ccfd8',
        'iris':'c4a7e7',
        'highlight': '403d52'
    }
    light = {
        'base':'faf4ed',
        'surface':'f2e9e1',
        'muted':'9893a5',
        'subtle':'797593',
        'text':'575279',
        'love':'b4637a',
        'gold':'ea9d34',
        'rose':'d7827e',
        'pine':'286983',
        'foam':'56949f',
        'iris':'907aa9',
        'highlight':'dfdad9'
    }
    if theme.lower() == 'dark':
        return dark
    elif theme.lower() == 'light':
        return light
    return {}

c = rosytheme(theme)


# create screen groups
groups = [Group(i) for i in "123456"]

# Auto bind mod + 0..9 keys for switching groups
# dgroups_key_binder = simple_key_binder(mod)
for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, 'shift'],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )


widget_defaults = dict(
    font="FiraCode Nerd Font Mono",
    fontsize=13,
    padding = 10,
    background = c['surface'],
    foreground = c['text']
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    background = c['iris'],
                    foreground = c['base'],
                    highlight_method = 'block',
                    active = c['foam'],
                    inactive = c['base'],
                    block_highlight_text_color = c['foam'],
                    urgent_border = c['love'],
                    urgent_text = c['base'],
                    padding_x = 5,
                    disable_drag = True,
                    use_mouse_wheel = False
                ),
                widget.TextBox(
                    fmt = '',
                    fontsize = 20,
                    foreground = c['iris'],
                    background = c['surface'],
                    padding = 0,
                    margin = 0
                ),
                widget.CurrentLayout(
                    foreground = c['subtle'],
                ),
                widget.TextBox(
                    fmt = '',
                    fontsize = 15,
                    foreground = c['subtle'],
                    padding = 0,
                    margin = 0
                ),
                widget.Prompt(
                    bell_style = None,
                    cursor = True,
                    cursor_color = c['text'],
                    prompt = 'Run  '
                ),
                widget.Notify(
                    background = c['iris'],
                    background_low = c['muted'],
                    background_urgent = c['rose'],
                    foreground = c['base'],
                    foreground_low = c['text'],
                    foreground_urgent = c['base'],
                    default_timeout = 15
                ),
                widget.Spacer(),
                widget.TextBox(
                    fmt = '',
                    fontsize = 15,
                    foreground = c['subtle'],
                    padding = 0,
                    margin = 0
                ),
                widget.Net(
                    format = '{down} ↓',
                    foreground = c['subtle'],
                ),
                widget.TextBox(
                    fmt = '',
                    fontsize = 20,
                    foreground = c['highlight'],
                    background = c['surface'],
                    padding = 0,
                    margin = 0
                ),
                widget.Wlan(
                    background = c['highlight'],
                    disconnected_message = 'ﲁ',
                    format = '說 {essid}',
                    interface = 'wlp2s0'
                ),
                widget.Battery(
                    background = c['highlight'],
                    battery = 'BAT0',
                    charge_char = '',
                    discharge_char = '',
                    empty_char = '',
                    full_char = '',
                    format = '{char} {percent:2.0%}',
                    low_percentage = 0.2,
                    low_background = c['love'],
                    low_foreground = c['base'],
                    notify_below = 20,
                    show_short_text = False,
                    update_interval = 5
                ),
                widget.Backlight(
                    background = c['highlight'],
                    # located in /sys/class/backlight/backlight_name/brightness_file
                    backlight_name = 'intel_backlight',
                    brightness_file = 'brightness',
                    step = 5,
                    format = '{percent:2.0%}',
                    update_interval = 0.1
                ),
                # widget.BatteryIcon(
                #     battery = 'BAT0',
                #     theme_path = '',
                #     scale = 0
                # ),
                widget.PulseVolume(
                    background = c['highlight'],
                    cardid = 1,
                    device = 'IEC958',
                    volume_app = 'amixer',
                    volume_up_command = 'amixer -c 1 sset Master 10%+',
                    volume_down_command = 'amixer -c 1 sset Master 10%-',
                    limit_max_volume = True
                ),
                widget.TextBox(
                    fmt = '',
                    fontsize = 20,
                    background = c['highlight'],
                    foreground = c['iris'],
                    padding = 0,
                    margin = 0
                ),
                widget.Clock(
                    background = c['iris'],
                    foreground = c['base'],
                    format = '%a, %m %d'
                ),
                widget.TextBox(
                    fmt = '',
                    fontsize = 20,
                    background = c['iris'],
                    foreground = c['gold'],
                    padding = 0,
                    margin = 0
                ),
                widget.Clock(
                    background = c['gold'],
                    foreground = c['base'],
                    format = '%I:%M %p'
                ),
                widget.TextBox(
                    fmt = '',
                    fontsize = 20,
                    background = c['gold'],
                    foreground = c['love'],
                    padding = 0,
                    margin = 0
                ),
                widget.QuickExit(
                    background = c['love'],
                    foreground = c['base'],
                    default_text = '⏻',
                    countdown_start = 7,
                    countdown_format = '{}s',
                    fontsize = 15
                ),
            ],
            22, # bar height
        ),
    ),
]


mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wmname = "LG3D"
