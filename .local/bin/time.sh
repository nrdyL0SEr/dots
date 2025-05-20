#!/bin/bash

while true; do
notify-send "$(date +'%b %d %a %H:%M:%S')" \
    -t 1100 \
    -h string:synchronous:time -h string:x-canonical-private-synchronous:time
sleep 1
done
