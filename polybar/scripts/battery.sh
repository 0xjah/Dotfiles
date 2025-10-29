#!/bin/bash

bats=$(acpi -b | grep -o '[0-9]\+%' | tr -d '%')
avg=$(echo "$bats" | awk '{sum+=$1} END {print int(sum/NR)}')

status=$(acpi -b | grep -o 'Charging\|Discharging\|Full' | sort -u)

if [ "$avg" -ge 90 ]; then
    icon="󰂂"
elif [ "$avg" -ge 60 ]; then
    icon="󰁿"
elif [ "$avg" -ge 40 ]; then
    icon="󰁽"
elif [ "$avg" -ge 20 ]; then
    icon="󰁻"
else
    icon="󰁺"
fi

if echo "$status" | grep -q "Charging"; then
    icon="󰂄"
fi

echo "BAT - $avg%"

