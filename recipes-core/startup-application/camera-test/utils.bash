#!/bin/bash

function get_index()
{
  local temp=`cat /home/root/temperature`
  local index=0

  exist=`ls $1_${temp}_*`
  if [ "$exist" != "" ] ; then
    root=$1_${temp}_
    len=${#root}
    len=$((len+1))
    index=`ls $1_${temp}_* | sort | cut -c${len}- | sort -nr | head -n 1 | tr -s "_" "\n" | tail -n 1`
  fi
  index=$((index+1))
  return $index
}
