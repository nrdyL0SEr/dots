#!/bin/bash

setsid -f ~/.local/bin/umpv "$1" >/dev/null 2>&1
notify-send -t 600 "Sent to umpv"
date +'%b %d %a %H:%M:%S' >> ~/Notes/yt_hist.txt
yt-dlp -a ~/.cache/input.txt --print "%(channel)s - %(duration>%H:%M:%S)s - %(title)s" $1 >> ~/Notes/yt_hist.txt
echo $1 >> ~/Notes/yt_hist.txt
notify-send -t 600 "Saved to history :)"
