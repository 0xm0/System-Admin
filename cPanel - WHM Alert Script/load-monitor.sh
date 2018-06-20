#!/bin/bash
# System Administrator script
# cPanel / WHM Load Monitor
# Created by David Brockway
# https://github.com/DavidBrockway

loadwarn=5.0

uptime="$(uptime)"
if $(echo $uptime | grep -E "min|days" >/dev/null); then
  ut=$(echo $uptime | awk '{ print $3 $4}')
else
  ut=$(echo $uptime | sed s/,//g| awk '{ print $3 " (hh:mm)"}')
fi
avgload="$(uptime |awk -F'average:' '{ print $2}')"
curload="$(echo $avgload | sed s/,//g | awk '{ print $2}')"
rusedram="$(free -mto | grep Mem: | awk '{ print $3 " MB" }')"
rfreeram="$(free -mto | grep Mem: | awk '{ print $4 " MB" }')"
rtotalram="$(free -mto | grep Mem: | awk '{ print $2 " MB" }')"
rtotalprocess="$($_CMD ps axue | grep -vE "^USER|grep|ps" | wc -l)"

str="============================="
warn1="WARNING: Server load is high!"
loadrpt="Current Load: $curload\nAverage Load:$avgload"
ruptime="Uptime: $ut"
ramrpt="Ram: $rusedram Used, $rfreeram Free, $rtotalram Total"
totalprocs="Total Processes: $rtotalprocess"

y="$(echo "$curload >= $loadwarn" | bc)"

if [ "$y" == "1" ]; then
  touch /tmp/tmp.00
  echo -e "$str\n$warn1\n$ruptime\n$loadrpt\n$ramrpt\n$totalprocs\n$str\n" >> /tmp/tmp.00
  ps aux | head -1 >> /tmp/tmp.00
  ps aux | sort -rn +2 | head -10 >> /tmp/tmp.00;
  mail -s "Alert: $curload Load for `hostname` on `date` " root < /tmp/tmp.00;
  cat /tmp/tmp.00
  rm -f /tmp/tmp.00
fi

exit 0
