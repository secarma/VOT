#!/bin/bash
if [[ $# -eq 0 ]]
then
	echo Usage: debugnetworking.sh [VOT ip] [gateway]
	echo e.g. debugnetworking.sh 10.0.0.10 10.0.0.1
	exit
fi
ip=$1
gateway=$2
interface=$(ifconfig | grep -B1 $ip | awk '$1!="inet" && $1!="--" {print $1
}'|cut -d":" -f1)
if [ -z "$interface" ]
then
	echo No interface has $ip set
	exit
else
	echo Interface: $interface has IP $ip
fi
pinggateway=$(ping $gateway -c1|grep "1 received")
if [ -z "$pinggateway" ]
then
	echo $ip on $interface cannot ping $gateway gateway
else
	echo $ip on $interface can ping $gateway gateway
fi
wget -q https://www.secarma.com
if [ $? -eq 0 ]
then
	echo $ip on $interface can reach https://www.secarma.com
else
	echo $ip on $interface cannot reach https://www.secarma.com
fi
ssh -q debian@18.135.241.72 exit
if [ $? -eq 0 ]
then
	echo $ip on $interface can SSH to debian@18.135.241.72
else
	echo $ip on $interface cannot SSH to debian@18.135.241.72
fi
