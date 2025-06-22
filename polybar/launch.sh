#!/bin/bash

# Kill existing bars
killall -q polybar

# Wait until they are really gone
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar named "example"
polybar &

