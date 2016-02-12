#!/bin/bash
    echo -e "`lsb_release -a | grep Description | cut -c 14-`" "`lsb_release -a | grep Release | cut -c 10-`" "`lsb_release -a | grep Codename | cut -c 11-`" "kernel `uname -r | cut -f 1-2 -d "-"`" "`uname -m`"
    echo -n "plasma `plasmashell -v | grep plasmashel | cut -c 13-`" "kapp `dolphin -v | grep dolphin | cut -c 10-`" "kde `kf5-config -v | grep KDE | cut -c 17-`" "qt `kf5-config -v | grep Qt | cut -c 5-`"
#   echo -n "`uname -n`" "`uptime -p`" #if you want to uncomment strings below, you need change 'echo -n' to 'echo -e'
#    echo -e "IPv6 `ifconfig teredo | grep 'inet6 2001' | cut -f 10 -d " "`"
#    echo -n "IPv4 `wget -q -O - https://api.ipify.org/`"
