#!/bin/bash
## Collect Real Time CPU Usage
## DATE: 12th July 2017
## Author: Ankam Ravi Kumar
CPU_USAGE=$(top -b -n2 -p 1 | fgrep "Cpu(s)" | tail -1 | awk '{ print $8 }' | cut -c1-2)
if [ $CPU_USAGE -le 10 ]; then
DATE=$(date "+%F %H:%M:%S")
CPU_USAGE1="$DATE CPU: $CPU_USAGE"
echo "CRITICAL $CPU_USAGE1% Idle" >> /opt/cpusage.out
cat /opt/cpusage.out |tail -5 > /tmp/cpusage.tmp
mail -s "CPU Utilization of `hostname`" EMAILADDRESS < /tmp/cpusage.tmp
elif [ $CPU_USAGE -ge 10 ] && [ $CPU_USAGE -le 20 ]; then
DATE=$(date "+%F %H:%M:%S")
CPU_USAGE1="$DATE CPU: $CPU_USAGE"
echo "WARNING $CPU_USAGE1% Idle" >> /opt/cpusage.out
cat /opt/cpusage.out |tail -5 > /tmp/cpusage.tmp
mail -s "CPU Utilization of `hostname`" EMAILADDRESS < /tmp/cpusage.tmp
else
DATE=$(date "+%F %H:%M:%S")
CPU_USAGE1="$DATE CPU: $CPU_USAGE"
echo "OK $CPU_USAGE1% Idle" >> /opt/cpusage.out
fi
