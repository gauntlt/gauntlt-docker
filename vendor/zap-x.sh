#!/bin/sh
export DISPLAY=:1.0
if [ ! -f /tmp/.X1-lock ]
then
  Xvfb :1 -screen 0 1024x768x16 -ac &
fi
zap.sh "$@"

# Shutdown xvfb
kill -9 `cat /tmp/.X1-lock`
rm -f /tmp/.X1-lock
