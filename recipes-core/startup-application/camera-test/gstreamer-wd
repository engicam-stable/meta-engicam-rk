#!/bin/sh

export XDG_RUNTIME_DIR=/run/user/0/

while true
do
  gst-launch-1.0 filesrc location=/home/root/F40.mp4 ! qtdemux ! h264parse ! mppvideodec ! videoconvert ! waylandsink
done
