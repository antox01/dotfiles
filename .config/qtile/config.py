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

import re

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook

from typing import List  # noqa: F401

mod = "mod4"
terminal = "termite"

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),

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

    # Screenshot utility
    #Key([], "Print", lazy.spawn(terminal + " -e scrot ~/Immagini/scrot-$(date --iso-8601='seconds').png -m -e 'xclip -selection c -t image/png < $f'"), desc="Take a screenshot and put it in the clipboard and in a file"),

    #Key(["shift"], "Print", lazy.spawn(terminal + " -e scrot ~/Immagini/scrot-$(date --iso-8601='seconds').png -s -e 'xclip -selection c -t image/png < $f'")), desc="Take a screenshot and put it in the clipboard and in a file"),

    # Change the volume if your keyboard has special volume keys.
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"), desc="Increase the volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"), desc="Decrease the volume"),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"), desc="Toggle the mute on the audio"),

    # Mapping another way to move between workspace
    Key([mod], "g", lazy.screen.next_group(), desc="Move to the next qtile group"),
    Key([mod, "shift"], "g", lazy.screen.prev_group(), desc="Move to the previous qtile group")
]

#groups = [Group(i) for i in "12345678"]
groups = [Group(i) for i in "12345678"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen()),

        # mod1 + shift + number of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
    ])

layouts = [
    layout.MonadTall(),
    layout.Max(),
    #layout.Stack(num_stacks=2),
    #layout.Bsp(),
    #layout.Columns(),
    layout.Matrix(),
    #layout.MonadWide(),
    #layout.RatioTile(),
    layout.Tile(shift_windows=True),
    #layout.TreeTab(),
    #layout.VerticalTile(),
    #layout.Zoomy(),
    layout.Floating()
]

widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=3,
    foreground='#ffffff'
)
extension_defaults = widget_defaults.copy()

##### COLORS #####
colors = [
        ["#282a36", "#282a36"], # panel background
        ["#434758", "#434758"], # background for current screen tab
        ["#ffffff", "#ffffff"], # font color for group names
        ["#ff5555", "#ff5555"], # border line color for current tab
        ["#bb10bb", "#bb10bb"], # border line color for other tab and odd widgets
        ["#668bd7", "#668bd7"], # color for the even widgets
        ["#e1acff", "#e1acff"], # window name
]

#### Bar options ####

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(),
                widget.WindowName(),
                widget.TextBox(
                        text='',
                        #background = colors[4],
                        foreground = colors[5],
                        padding=0,
                        fontsize=37
                ),
                widget.TextBox(
                        text=" 🖬",
                        foreground=colors[2],
                        background=colors[5],
                        padding = 0,
                        fontsize=14
                ),
                widget.memory.Memory(
                        foreground = colors[2],
                        background = colors[5],
                        padding = 5
                ),
                widget.TextBox(
                        text='',
                        background = colors[5],
                        foreground = colors[4],
                        padding=0,
                        fontsize=37
                ),
                widget.net.Net(
                        interface = "wlan0",
                        format = '{down} ↓↑ {up}',
                        foreground = colors[2],
                        background = colors[4],
                        padding = 5
                ),
                widget.TextBox(
                        text='',
                        background = colors[4],
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
                ),
                widget.TextBox(
                        text='',
                        background = colors[5],
                        foreground = colors[4],
                        padding=0,
                        fontsize=37
                ),
                widget.TextBox(
                        text='Vol:',
                        background = colors[4],
                        foreground = colors[2],
                        padding=4,
                ),
                widget.volume.Volume(
                        background = colors[4]
                ),
                widget.TextBox(
                        text='',
                        background = colors[4],
                        foreground = colors[5],
                        padding=0,
                        fontsize=37
                ),
                widget.Systray(
                        background = colors[5]
                ),
                widget.sep.Sep(
                        foreground = colors[5],
                        background = colors[5]
                ),
                widget.CurrentLayout(
                        background = colors[5]
                ),
                widget.TextBox(
                        text='',
                        background = colors[5],
                        foreground = colors[4],
                        padding=0,
                        fontsize=37
                ),
                widget.Clock(
                        format='%Y-%m-%d %a %H:%M %p',
                        background = colors[4]
                ),
                widget.TextBox(
                        text='',
                        background = colors[4],
                        foreground = colors[0],
                        padding=0,
                        fontsize=37
                ),
                widget.QuickExit(),
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
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
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
