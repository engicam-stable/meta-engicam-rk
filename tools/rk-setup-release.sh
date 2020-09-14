#!/bin/bash

machines=`ls meta-engicam-rk/conf/machine/*.conf \
| sed s/\.conf//g | sed -r 's/^.+\///' | xargs -I% echo -e "\t%"`

arr=($machines)

good_machine="false"
for var in "${arr[@]}"
do
  if [ "$1" = "${var}" ]; then
    good_machine="true"
  fi
done

if [ "$good_machine" = "false" ]; then
  echo "
  Usage: rk-setup-release.sh <machine>

  Supported machines are:
  `echo; ls meta-engicam-rk/conf/machine/*.conf | grep -v common.conf \
  | sed s/\.conf//g | sed -r 's/^.+\///' | xargs -I% echo -e "\t%"`
  "
  exit 1
fi

cd build/conf/
ln -fs $1.conf local.conf
echo "machine configured"
