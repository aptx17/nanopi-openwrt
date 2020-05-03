#!/bin/sh

echo '脚本检测开始'
tries=0
wan=`ifconfig |grep inet| sed -n '1p'|awk '{print $2}'|awk -F ':' '{print $2}'`
while test "1" = "1"
do
# do something
if ping -w 1 -c 1 119.29.29.29; then #ping dns通则
	echo '网络正常'
	tries=0
else
	sleep 2
		tries=$((tries+1))
	if [ $tries -ge 3 ]; then #连续ping dns 3次失败，重启wan、lan口
		/sbin/ifup wan
		/sbin/ifup lan
	     sleep 1080
	fi
fi
sleep 180
done
