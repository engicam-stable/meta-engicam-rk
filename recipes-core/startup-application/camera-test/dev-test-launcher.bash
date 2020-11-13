#!/bin/bash

path="/home/root"

memory=26000K # 2GB
#memory=13000K # 1GB
#memory=6500K # 512M
time=900 # 15 minuti
#time=86400 # 24 ore

temp=`cat /home/root/temperature`

source ${path}/utils.bash
sleep 5

## ethernet
out_ping="${path}/ping_out"
err_ping="${path}/ping_err"
opi="$(get_index $out_ping)" # output ping index
epi="$(get_index $err_ping)" # error ping index

ping 192.168.2.230 -c $time 1>${out_ping}_${temp}_${opi} 2>${err_ping}_${temp}_${epi} &

## memory, cpu, disk
out_stress="${path}/stress_out"
err_stress="${path}/stress_err"
osi="$(get_index $out_stress)" # output stress index
esi="$(get_index $err_stress)" # error stress index

## 85 processi cpu
stress --cpu 10 --timeout $time 1>>${out_stress}_${temp}_${osi} 2>>${err_stress}_${temp}_${esi} &
sleep 2
stress --cpu 10 --timeout $time 1>>${out_stress}_${temp}_${osi} 2>>${err_stress}_${temp}_${esi} &
sleep 2
stress --cpu 10 --timeout $time 1>>${out_stress}_${temp}_${osi} 2>>${err_stress}_${temp}_${esi} &
sleep 2
stress --cpu 10 --timeout $time 1>>${out_stress}_${temp}_${osi} 2>>${err_stress}_${temp}_${esi} &
sleep 2
stress --cpu 10 --timeout $time 1>>${out_stress}_${temp}_${osi} 2>>${err_stress}_${temp}_${esi} &
sleep 2
stress --cpu 10 --timeout $time 1>>${out_stress}_${temp}_${osi} 2>>${err_stress}_${temp}_${esi} &
sleep 2
stress --cpu 10 --timeout $time 1>>${out_stress}_${temp}_${osi} 2>>${err_stress}_${temp}_${esi} &
sleep 2
stress --cpu 10 --timeout $time 1>>${out_stress}_${temp}_${osi} 2>>${err_stress}_${temp}_${esi} &
sleep 2
stress --cpu 5 --timeout $time 1>>${out_stress}_${temp}_${osi} 2>>${err_stress}_${temp}_${esi} &
sleep 2
## 65 processi su ram (da parametrizzare il numero di memoria in KB)
stress --vm 7 --vm-bytes $memory --timeout $time 1>>${out_stress}_${temp}_${osi} 2>>${err_stress}_${temp}_${esi} &
sleep 2
stress --vm 8 --vm-bytes $memory --timeout $time 1>>${out_stress}_${temp}_${osi} 2>>${err_stress}_${temp}_${esi} &
sleep 2
stress --vm 7 --vm-bytes $memory --timeout $time 1>>${out_stress}_${temp}_${osi} 2>>${err_stress}_${temp}_${esi} &
sleep 2
stress --vm 8 --vm-bytes $memory --timeout $time 1>>${out_stress}_${temp}_${osi} 2>>${err_stress}_${temp}_${esi} &
sleep 2
stress --vm 7 --vm-bytes $memory --timeout $time 1>>${out_stress}_${temp}_${osi} 2>>${err_stress}_${temp}_${esi} &
sleep 2
stress --vm 8 --vm-bytes $memory --timeout $time 1>>${out_stress}_${temp}_${osi} 2>>${err_stress}_${temp}_${esi} &
sleep 2
stress --vm 10 --vm-bytes $memory --timeout $time 1>>${out_stress}_${temp}_${osi} 2>>${err_stress}_${temp}_${esi} &
sleep 2
stress --vm 10 --vm-bytes $memory --timeout $time 1>>${out_stress}_${temp}_${osi} 2>>${err_stress}_${temp}_${esi} &
sleep 2
## 10 processi su hdd (agiscono su ram e cpu)
stress --hdd 5 --hdd-bytes 9437184 --timeout $time 1>>${out_stress}_${temp}_${osi} 2>>${err_stress}_${temp}_${esi} &
sleep 2
stress --hdd 5 --hdd-bytes 9437184 --timeout $time 1>>${out_stress}_${temp}_${osi} 2>>${err_stress}_${temp}_${esi} &
sleep 2
## 10 processi su io (agiscono su ram e cpu)
stress --io 5 --timeout $time 1>>${out_stress}_${temp}_${osi} 2>>${err_stress}_${temp}_${esi} &
sleep 2
stress --io 5 --timeout $time 1>>${out_stress}_${temp}_${osi} 2>>${err_stress}_${temp}_${esi} &
sleep 2

## USB and SD card
out_usb="${path}/usb_out"
out_card="${path}/card_out"
err_usb="${path}/usb_err"
err_card="${path}/card_err"
oui="$(get_index $out_usb)" # output usb index
oci="$(get_index $out_card)" # output card index
eui="$(get_index $err_usb)" # error usb index
eci="$(get_index $err_card)" # error card index

dev_usb=/dev/sda1
dev_card=/dev/mmcblk0p1
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
