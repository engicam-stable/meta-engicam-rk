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
  echo $index
}

function get_decimal()
{
  local hi_byte="${1:4:2}"
  local lo_byte="${1:2:2}"
  local hex="${hi_byte}${lo_byte}"

  local dec=$(( 16#$hex ))
  echo $dec
}

function get_celsius()
{
  local hi_byte="${1:4:2}"
  local lo_byte="${1:2:2}"

  local hi_byte_dec=$(( 16#$hi_byte ))
  local lo_byte_dec=$(( 16#$lo_byte ))

  local calc=$((hi_byte_dec * 16 * 1000 + lo_byte_dec / 16 * 1000))
  echo $calc
}
