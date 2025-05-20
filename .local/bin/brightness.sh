#!/bin/sh
current_abs=$(brightnessctl get)
current_rel() {
    echo "$(brightnessctl get) * 100 / $(brightnessctl max)" | bc 
} 
get_brightness_info() {
    brightness=$(brightnessctl g)
    max_brightness=$(brightnessctl m)
    brightness_percent=$((brightness * 100 / max_brightness))
}
max=$(brightnessctl max)
factor=1
brightness_step=$((max * factor / 100 < 1 ? 1 : max * factor / 100))

case $1'' in
    '') ;;
    'down')
        # if current value <= 3% and absolute value != 1, set brightness to absolute 1
        if [ "$(current_rel)" -le "$factor" ] && [ "$current_abs" -ge 0 ]; then
            brightnessctl --quiet set 1
            get_brightness_info
            notify-send "Brightness: ${brightness_percent}%" \
                -t 1000 \
            -h int:value:$brightness_percent \
                -h string:synchronous:brightness-$brightness_percent \
                -h string:x-canonical-private-synchronous:brightness 
        else
            brightnessctl --quiet set "${brightness_step}-"
            get_brightness_info
            notify-send "Brightness: ${brightness_percent}%" \
                -t 1000 \
            -h int:value:$brightness_percent \
                -h string:synchronous:brightness-$brightness_percent \
                -h string:x-canonical-private-synchronous:brightness
        fi
        ;;
    'up')
        brightnessctl --quiet set "${brightness_step}+"
        get_brightness_info
        notify-send  "Brightness: ${brightness_percent}%" \
            -t 1000 \
            -h int:value:$brightness_percent \
            -h string:synchronous:brightness-$brightness_percent \
            -h string:x-canonical-private-synchronous:brightness 
        ;;
esac
current_rel
