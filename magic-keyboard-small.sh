#! /bin/bash

set -e

setxkbmap -option caps:escape

xmodmap -e "remove mod1 = Alt_L"
xmodmap -e "remove mod4 = Super_L"
xmodmap -e "remove mod4 = Super_R"
xmodmap -e "remove mod1 = Alt_R"

xmodmap -e "keycode 64 = Super_L"
xmodmap -e "keycode 133 = Alt_L"
xmodmap -e "keycode 134 = Alt_R"
xmodmap -e "keycode 108 = Control_R"

xmodmap -e "add mod4 = Super_L"
xmodmap -e "add mod1 = Alt_L"
xmodmap -e "add mod1 = Alt_R"
xmodmap -e "add control = Control_R"
