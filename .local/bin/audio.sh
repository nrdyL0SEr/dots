#!/bin/bash
# Function to get volume and mute status
get_volume_info() {
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk -F '.' '{print $2}')
    mute_status=$(pactl get-sink-mute @DEFAULT_SINK@)
}

# Function to determine the appropriate Unicode icon
case $1 in
    down)
        wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%-
        ;;
    up)
        wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+
        ;;
    downfive)
        wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-
        ;;
    upfive)
        wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        exit 1
        ;;
    *)
        echo "Usage: $pulse {down|up|mute}"
        exit 1
        ;;
esac
# Get updated volume info
get_volume_info
# Send notification using Mako
notify-send "Volume: $volume%" \
    -h int:value:$volume \
    -t 1000 \
    -e \
    -u low \
    -h string:synchronous:volume-$volume \
    -h string:x-canonical-private-synchronous:volume
