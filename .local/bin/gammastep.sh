#!/bin/bash
# https://github.com/FuSiioNz/dotfiles/blob/main/hypr/scripts/brightness-control.sh
# and manjaro-sway scripts (same for volume)
# https://github.com/frolickingpotato/waybar-gammastep/blob/main/gammastep.sh (for gamma)
temperature=$(<~/.local/bin/gammastep_temperature)
oldpid=$(<~/.local/bin/gammastep_pid)
temperature=$((temperature + $1))

if [ $temperature -gt 6500 ]; then
    temperature=6500
elif [ $temperature -lt 1000 ]; then
    temperature=1000
else
    echo $temperature > ~/.local/bin/gammastep_temperature
    exec gammastep -Pr -O $temperature &
    pid=$!
    echo $pid > ~/.local/bin/gammastep_pid
    kill $oldpid
fi
notify-send "Gamma: ${temperature}" \
    -t 1000 \
    --hint=string:x-dunst-stack-tag:gamma \
    --hint=string:synchronous:gamma \
