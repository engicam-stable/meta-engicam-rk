#!/bin/bash

source utils.bash

path="/home/root"
time=900
temp=`cat /home/root/temperature`

## ethernet
out_ping="${path}/ping_out"
err_ping="${path}/ping_err"
get_index $out_ping
opi=$? # output ping index
get_index $err_ping
epi=$? # error ping index

ping 192.168.2.230 -c $time 1>${out_ping}_${temp}_${opi} 2>${err_ping}_${temp}_${epi} &

## USB

## memory, cpu, disk
out_stress="${path}/stress_out"
err_stress="${path}/stress_err"
get_index $out_stress
osi=$? # output stress index
get_index $err_stress
esi=$? # error stress index

stress --cpu 8 --vm 8 --vm-bytes 200M --hdd 8 --hdd-bytes 3145728 --io 8 --timeout $time 1>${out_stress}_${temp}_${osi} 2>${err_stress}_${temp}_${esi} &
