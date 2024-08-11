#!/bin/bash

get_volume() {
    default_source=$(pactl info | grep "Default Source" | awk '{print $3}')
    volume=$(pactl list sources | grep -A 15 "$default_source" | grep -m 1 "Volume" | awk '{print $5}')
    mute_status=$(pactl list sources | grep -A 15 "$default_source" | grep -m 1 "Mute" | awk '{print $2}')
    volume="${volume%?}"
    if [ "$mute_status" = "yes" ]; then
        echo "无声"
    else
        echo "%{F#c4a7e7}麦%{F-} ${volume}%"
    fi
}
case "$1" in
    inc)
        pactl set-source-volume @DEFAULT_SOURCE@ +5%
        ;;
    dec)
        pactl set-source-volume @DEFAULT_SOURCE@ -5%
        ;;
    toggle)
        pactl set-source-mute @DEFAULT_SOURCE@ toggle
        ;;
esac
get_volume
