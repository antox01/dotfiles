# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess
import socket
import re

from libqtile.config import Key, Screen, Group, Match, Drag, Click
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook

from typing import List  # noqa: F401

mod = "mod4"
terminal = "st"
browser = "firefox"
browser_class = "Google-chrome"

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),

    # Only for monadtall layout
    Key([mod], "l", lazy.layout.shrink()),
    Key([mod], "h", lazy.layout.grow()),

    # Move windows up or down in current stack
    Key([mod, "shift"], "k", lazy.layout.shuffle_down(), desc="Move the focused window down in the stack"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_up(), desc="Move the focused window up in the stack"),

    Key([mod], "space", lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="TODO"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Open the selected terminal emulator"),
    Key([mod], "w", lazy.spawn(browser), desc="Open the selected browser"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Switch to the next layout into the group"),
    Key([mod, "shift"], "Tab", lazy.prev_layout(), desc="Switch to the previous layout into the group"),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Close the focused window"),

    Key([mod, "shift"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown the current session of qtile"),
    Key([mod], "r", lazy.spawn("dmenu_run -p 'Run: '"), desc="dmenu application launcher"),

    # Toggle the fullscreen setting
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window"),
    #Toggle the floating mode on a window
    Key([mod, "shift"], "f", lazy.window.toggle_floating(), desc="Toggle floating mode on the focused window"),

    # Change the volume if your keyboard has special volume keys.
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"), desc="Increase the volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"), desc="Decrease the volume"),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"), desc="Toggle the mute on the audio"),

    # Mapping another way to move between workspace
    Key([mod], "g", lazy.screen.next_group(), desc="Move to the next qtile group"),
    Key([mod, "shift"], "g", lazy.screen.prev_group(), desc="Move to the previous qtile group")
]

#groups = [Group(i) for i in "12345678"]
groups_name = [
        ("DEV", {"layout": "monadtall"}),
        ("WWW", {"layout": "monadtall", "matches": [Match(wm_class=[browser_class])]}),
        ("CHAT", {"layout": "monadtall", "matches": [Match(wm_class=["TelegramDesktop"])]}),
        ("GFX", {"layout": "monadtall"}),
        ("DOC", {"layout": "monadtall"}),
        ("MUS", {"layout": "monadtall"}),
        ("VID", {"layout": "monadtall"}),
]
groups = [Group(i, **kargs) for i, kargs in groups_name]

for i in range(len(groups)):
    keys.extend([
        Key([mod], str(i+1), lazy.group[groups[i].name].toscreen()), # Switch to another group
        Key([mod, "shift"], str(i+1), lazy.window.togroup(groups[i].name, switch_group=True)), # Move focused window to group and switch to it
    ])

##### COLORS #####
colors = [
        ["#1e1e1e", "#1e1e1e"], # background
        ["#ffffff", "#ffffff"], # foreground
        ["#1c1e22", "#1c1e22"], # color0
        ["#aa2727", "#aa2727"], # color1
        ["#639440", "#639440"], # color2
        ["#dc6c1e", "#dc6c1e"], # color3
        ["#5f819d", "#5f819d"], # color4
        ["#7e4092", "#7e4092"], # color5
        ["#649693", "#649693"], # color6
        ["#bac2c9", "#bac2c9"], # color7
        ["#434758", "#434758"], # background for current screen tab
]

##### DEFAULT THEME SETTINGS FOR LAYOUTS #####
layout_theme = {
        "border_width": 2,
        "margin": 10,
        "border_focus": "#bac2c9",
        "border_normal": "#1D2330"
}

layouts = [
    #layout.Stack(num_stacks=2),
    #layout.Bsp(),
    #layout.Columns(),
    #layout.MonadWide(),
    #layout.RatioTile(),
    #layout.TreeTab(),
    #layout.VerticalTile(),
    #layout.Zoomy(),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.Matrix(**layout_theme),
    layout.Tile(shift_windows=True, **layout_theme),
    layout.Floating(**layout_theme)
]

widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=3,
    foreground='#ffffff'
)
extension_defaults = widget_defaults.copy()

#### Bar options ####

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                        font = "UbuntuMono Nerd Font Bold",
                        fontsize = 11,
                        margin_y = 3,
                        margin_x = 0,
                        padding_y = 5,
                        padding_x = 7,
                        borderwidth = 3,
                        active = colors[1],
                        inactive = colors[1],
                        rounded = False,
                        highlight_color = colors[10],
                        highlight_method = "line",
                        this_current_screen_border = colors[3],
                        this_screen_border = colors[4],
                        other_current_screen_border = colors[0],
                        other_screen_border = colors[0],
                        foreground = colors[1],
                        background = colors[0]
                ),
                widget.WindowName(
                        foreground = colors[1],
                ),
                widget.TextBox(
                        text='',
                        foreground = colors[5],
                        padding=0,
                        fontsize=37
                ),
                widget.TextBox(
                        text=" 🖬",
                        foreground=colors[1],
                        background=colors[5],
                        padding = 0,
                        fontsize=14
                ),
                widget.memory.Memory(
                        foreground = colors[1],
                        background = colors[5],
                        padding = 5
                ),
                widget.TextBox(
                        text='',
                        background = colors[5],
                        foreground = colors[3],
                        padding=0,
                        fontsize=37
                ),
                widget.net.Net(
                        interface = "wlan0",
                        format = '{down} ↓↑ {up}',
                        foreground = colors[1],
                        background = colors[3],
                        padding = 5
                ),
                widget.TextBox(
                        text='',
                        background = colors[3],
                        foreground = colors[5],
                        padding=0,
                        fontsize=37
                ),
                widget.battery.Battery(
                        battery=0,
                        charge_char='🔌',
                        discharge_char='🔋',
                        full_char='',
                        format="{char} {percent:2.0%} {hour:d}:{min:02d}",
                        update_interval=10,
                        background = colors[5],
                        foreground = colors[1],
                ),
                widget.TextBox(
                        text='',
                        background = colors[5],
                        foreground = colors[3],
                        padding=0,
                        fontsize=37
                ),
                widget.TextBox(
                        text='Vol:',
                        background = colors[3],
                        foreground = colors[1],
                        padding=4,
                ),
                widget.volume.Volume(
                        background = colors[3],
                        foreground = colors[1],
                ),
                widget.TextBox(
                        text='',
                        background = colors[3],
                        foreground = colors[5],
                        padding=0,
                        fontsize=37
                ),
                widget.CurrentLayout(
                        foreground = colors[1],
                        background = colors[5]
                ),
                widget.TextBox(
                        text='',
                        background = colors[5],
                        foreground = colors[3],
                        padding=0,
                        fontsize=37
                ),
                widget.Clock(
                        format='%Y-%m-%d %a %H:%M %p',
                        foreground = colors[1],
                        background = colors[3]
                ),
                widget.TextBox(
                        text='',
                        background = colors[3],
                        foreground = colors[0],
                        padding=0,
                        fontsize=37
                ),
                widget.Systray(
                        background = colors[0]
                ),
                widget.QuickExit(
                        default_text = "",
                        font = "UbuntuMono Nerd Font"
                ),
            ],
            22,
            #background='#1f1f1f',
            background=colors[0],
            opacity=0.9
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    # Set another way to resize window when not using a mouse
    Drag([mod, "shift"], "Button1", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

##### STARTUP APPLICATIONS #####
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autorun.sh')
    subprocess.call([home])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
