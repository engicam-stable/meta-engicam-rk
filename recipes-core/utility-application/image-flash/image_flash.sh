#!/bin/sh

if [ $(id -u) -ne 0 ]
then
  echo "Please run as root"
  exit 1
fi

if [ "$1" = "" ]
then
  echo "Usage: image_flash.sh device image_path"
  exit 1
fi

if [ ! -e "$1" ]
then
  echo "device $1 not found"
  exit 1
fi

if [ "$2" != "" ]
then
  image_path=$2
else
  echo "Usage: image_flash.sh device image_path"
  exit 1
fi

if [ ! -d "$image_path" ]
then
  echo "image path $image_path not found"
  exit 1
fi

if [ ! -e "${image_path}/idbloader.img" ]
then
  echo "${image_path}/idbloader.img not found"
  exit 1
fi

if [ ! -e "${image_path}/uboot.img" ]
then
  echo "${image_path}/uboot.img not found"
  exit 1
fi

if [ ! -e "${image_path}/trust.img" ]
then
  echo "${image_path}/trust.img not found"
  exit 1
fi

if [ ! -e "${image_path}/boot.img" ]
then
  echo "${image_path}/boot.img not found"
  exit 1
fi

if [ ! -e "${image_path}/rootfs.img" ]
then
  echo "${image_path}/rootfs.img not found"
  exit 1
fi

echo "deleting old partitions"

sgdisk -g -d 1 $1
sgdisk -g -d 2 $1
sgdisk -g -d 3 $1
sgdisk -g -d 4 $1
sgdisk -g -d 5 $1

echo "creating partitions"

sgdisk -n 1:64:7167 $1
sgdisk -n 2:16384:24575 $1
sgdisk -n 3:24576:32767 $1
sgdisk -n 4:32768:262143 $1
sgdisk -n 5 $1
sgdisk -c 4:boot $1
sgdisk -c 5:rootfs $1
sgdisk -u 5:614e0000-0000-4b53-8000-1d28000054a9 $1

echo "writing image"

dd if=${image_path}/idbloader.img of=$1 seek=64
dd if=${image_path}/uboot.img of=$1 seek=16384
dd if=${image_path}/trust.img of=$1 seek=24576
dd if=${image_path}/boot.img of=$1 seek=32768
dd if=${image_path}/rootfs.img of=$1 seek=262144

sync

echo "done"
