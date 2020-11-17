#!/bin/bash

path="/home/root"
temp=`cat /home/root/temperature`

source ${path}/utils.bash

## monitor of CPU and memory usage, processor temperature
out_sysmonitor="${path}/sysmonitor"
omi="$(get_index $out_sysmonitor)" # output monitor index

while true
do
  top=`top -b -n1 | awk 'xor(/CPU:/,/Mem:/)' | tr "\n" " "`
  cpu_temp=`cat /sys/class/thermal/thermal_zone0/temp`
  date=`date`
  volt=`i2cget -y 2 0x40 0x1 w 2>/dev/null` #convertire in decimale, i 2 byte hex sono invertiti
  pack_temp=`i2cget -y 2 0x67 0x00 w 2>/dev/null` #i 2 byte hex sono invertiti: high_byte(convertito in decimale) x 16 + low_byte(convertito in decimale) / 16
  amb_temp=`i2cget -y 2 0x67 0x02 w 2>/dev/null` #i 2 byte hex sono invertiti: high_byte(convertito in decimale) x 16 + low_byte(convertito in decimale) / 16

  board_curr="unknown"
  pack_temp_celsius="unknown"
  amb_temp_celsius="unknown"
  if [[ $volt != "" ]]; then
    volt_dec="$(get_decimal $volt)"
    board_curr=$((volt_dec / 10))
  fi
  if [[ $pack_temp != "" ]]; then
    pack_temp_celsius="$(get_celsius $pack_temp)"
  fi
  if [[ $amb_temp != "" ]]; then
    amb_temp_celsius="$(get_celsius $amb_temp)"
  fi

  echo "Date:" $date $top "BoardCurr [mA]:" $board_curr "CPUTemp [m°C]:" $cpu_temp "PackTemp [m°C]:" $pack_temp_celsius "AmbTemp [m°C]:" $amb_temp_celsius 1>>${out_sysmonitor}_${temp}_${omi}
done
