#!/bin/bash

path="/home/root"
time=900
temp=`cat /home/root/temperature`

source ${path}/utils.bash

## monitor of CPU and memory usage, processor temperature
out_sysmonitor="${path}/sysmonitor"
get_index $out_sysmonitor
omi=$? # output monitor index

while true
do
  top -b -n1 | awk 'xor(/CPU:/,/Mem:/)' 1>>${out_sysmonitor}_${temp}_${omi}
  cpu_temp=`cat /sys/class/thermal/thermal_zone0/temp`
  echo "Temp: " $cpu_temp 1>>${out_sysmonitor}_${temp}_${omi}
  sleep 1
done
