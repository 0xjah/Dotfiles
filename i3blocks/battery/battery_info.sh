#!/bin/sh

ACPI_RES=$(acpi -b)
ACPI_CODE=$?

if [ $ACPI_CODE -eq 0 ]; then
    BAT_LEVEL=$(echo "$ACPI_RES" | grep -oP '\d+(?=%)' | head -n 1)
    IS_CHARGING=$(echo "$ACPI_RES" | grep -o "Charging")

    if [ -z "$BAT_LEVEL" ]; then
        BAT_LEVEL=0
    fi

    if [ "$IS_CHARGING" = "Charging" ]; then
        ICON="󰂄"  # Battery charging icon
    elif [ "$BAT_LEVEL" -le 15 ]; then
        ICON=""  # Battery low icon
    elif [ "$BAT_LEVEL" -le 50 ]; then
        ICON=""  # Battery medium icon
    else
        ICON=""  # Battery full icon
    fi

    # Output battery status with color logic
    echo "$ICON:$BAT_LEVEL%"
    echo "$ICON:$BAT_LEVEL%"

    # Set color based on battery level
    if [ "$IS_CHARGING" = "Charging" ]; then
        echo "#FFFF00"  # Yellow for charging
    elif [ "$BAT_LEVEL" -le 15 ]; then
        echo "#FF0000"  # Red for critical battery
    else
        echo "#00FF00"  # Green for sufficient battery
    fi
fi
