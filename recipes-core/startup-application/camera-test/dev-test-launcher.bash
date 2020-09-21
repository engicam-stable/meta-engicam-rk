#!/bin/bash

path="/home/root"
time=900
temp=`cat /home/root/temperature`

source ${path}/utils.bash
sleep 5

## ethernet
out_ping="${path}/ping_out"
err_ping="${path}/ping_err"
get_index $out_ping
opi=$? # output ping index
get_index $err_ping
epi=$? # error ping index

ping 192.168.2.230 -c $time 1>${out_ping}_${temp}_${opi} 2>${err_ping}_${temp}_${epi} &

## memory, cpu, disk
out_stress="${path}/stress_out"
err_stress="${path}/stress_err"
get_index $out_stress
osi=$? # output stress index
get_index $err_stress
esi=$? # error stress index

stress --cpu 10 --vm 64 --vm-bytes 25M --hdd 8 --hdd-bytes 3145728 --io 8 --timeout $time 1>${out_stress}_${temp}_${osi} 2>${err_stress}_${temp}_${esi} &

## CPU and memory usage
out_top="${path}/top"
get_index $out_top
oti=$? # output top index

top -b | awk 'xor(/CPU:/,/Mem:/)' 1>${out_top}_${temp}_${oti} &

## USB
out_usb="${path}/usb_out"
err_usb="${path}/usb_err"
get_index $out_usb
oui=$? # output usb index
get_index $err_usb
eui=$? # error usb index

dev=/dev/sda1
while true
do
  if [ -e "$dev" ]
  then
    mount $dev /mnt
    cp ${path}/F40.mp4 /mnt/
    sync
    md5=`md5sum /mnt/F40.mp4`
    if [ "${md5:0:32}" = "8bc17947edaa4d54adbdc00bc6810578" ]
    then
      echo "file correctly writed and read from USB" >> ${out_usb}_${temp}_${oui}
    else
      echo "error reading file from USB" >> ${err_usb}_${temp}_${oui}
    fi
  else
    echo "error no USB founded" >> ${err_usb}_${temp}_${oui}
    sleep 5
  fi
done
