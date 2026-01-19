#!/usr/bin/env bash

# Terminate already running polybar instances
pkill -x polybar

# Wait until polybar processes are gone
while pgrep -x polybar >/dev/null; do
  sleep 1
done

# Launch Polybar on each connected monitor
if command -v xrandr >/dev/null 2>&1; then
  for monitor in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$monitor polybar --reload main &
  done
else
  polybar --reload main &
fi

