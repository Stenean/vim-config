#!/bin/bash

if [ "$1" == 'mute' ]; then
    if [ "$2" == 'on' ]; then
        sudo -u kuba pactl set-sink-mute 0 1
    fi
    if [ "$2" == 'off' ]; then
        sudo -u kuba pactl set-sink-mute 0 0
    fi
fi
if [ "$1" == 'volume' ]; then
    sudo -u kuba pactl set-sink-mute 0 0
    sudo -u kuba pactl set-sink-volume 0 "$2%"
fi;
