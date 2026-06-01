#!/bin/bash
status=$(playerctl -p spotify status 2>/dev/null)
if [[ "$status" == "Playing" ]]; then
    playerctl -p spotify pause
else
    playerctl -p spotify play
fi
