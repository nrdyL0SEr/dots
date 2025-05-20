#!/bin/bash

op=$( echo -e "Record Screen\nRecord Screen and Audio\nScreenshot Area\nScreenshot Window\nWebcam Preview" | tofi)

case $op in 
    "Record Screen")
        wf-recorder -g "$(slurp)"
        ;;
    "Record Screen and Audio")
        exec wf-recorder --audio
        ;;
    "Screenshot Area")
        grimshot save area
        ;;
    "Screenshot Window")
        grimshot save window
        ;;
    "Webcam Preview")
        mpv av://v4l2:/dev/video0 --profile=low-latency --untimed
        ;;
esac
