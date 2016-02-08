#!/bin/bash
echo -e "IPv6 `ifconfig teredo | grep 'inet6 2001' | cut -f 10 -d " "`"
echo -n "IPv4 `wget -q -O - http://ip-api.com/json | cut -f 9 -d "," | cut -f 2 -d ":" | sed -e 's/"//g'`"
