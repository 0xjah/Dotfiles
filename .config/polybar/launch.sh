#!/bin/bash

# Kill existing bars
killall -q polybar

# Wait until they are really gone
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar named "example"
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload example &
  done
else
  polybar --reload example &
fi

