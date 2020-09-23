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

stress --cpu 70 --vm 64 --vm-bytes 25M --hdd 8 --hdd-bytes 3145728 --io 8 --timeout $time 1>${out_stress}_${temp}_${osi} 2>${err_stress}_${temp}_${esi} &

## USB and SD card
out_usb="${path}/usb_out"
out_card="${path}/card_out"
err_usb="${path}/usb_err"
err_card="${path}/card_err"
get_index $out_usb
oui=$? # output usb index
get_index $out_card
oci=$? # output card index
get_index $err_usb
eui=$? # error usb index
get_index $err_card
eci=$? # error card index

dev_usb=/dev/sda1
dev_card=/dev/mmcblk0p5
path_usb=/mnt/usb
path_card=/mnt/card

mkdir $path_usb
mkdir $path_card
while true
do
  if [ -e "$dev_usb" ]
  then
    mount $dev_usb $path_usb
    cp ${path}/F40.mp4 $path_usb
    sync

    md5u=`md5sum $path_usb/F40.mp4`
    if [ "${md5u:0:32}" = "8bc17947edaa4d54adbdc00bc6810578" ]
    then
      echo "file correctly writed and read from USB" >> ${out_usb}_${temp}_${oui}
    else
      echo "error reading file from USB" >> ${err_usb}_${temp}_${eui}
    fi
  else
    echo "error no USB founded" >> ${err_usb}_${temp}_${eui}
  fi

  if [ -e "$dev_card" ]
  then
    mount $dev_card $path_card
    cp ${path}/F40.mp4 $path_card
    sync

    md5c=`md5sum $path_card/F40.mp4`
    if [ "${md5c:0:32}" = "8bc17947edaa4d54adbdc00bc6810578" ]
    then
      echo "file correctly writed and read from SD" >> ${out_card}_${temp}_${oci}
    else
      echo "error reading file from SD" >> ${err_card}_${temp}_${eci}
    fi
  else
    echo "error no SD founded" >> ${err_card}_${temp}_${eci}
  fi

  sleep 1
done
