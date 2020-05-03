#!/bin/sh

while true; do
    wan=`/sbin/ifconfig |grep inet| sed -n '1p'|awk '{print $2}'|awk -F ':' '{print $2}'`
    r=`ping -c1 $wan 2>&1`
    case $r in
        *permitted* ) /etc/init.d/firewall reload ;;
    esac
    sleep 20
done
