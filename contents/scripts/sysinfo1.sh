#!/bin/bash
echo -n "`uname -n`" "`uptime -p`" #if you want to uncomment strings below, you need change 'echo -n' to 'echo -e'
#echo -e "IPv6 `ifconfig teredo | grep 'inet6 2001' | cut -f 10 -d " "`"
#echo -n "IPv4 `wget -q -O - https://api.ipify.org/`"
