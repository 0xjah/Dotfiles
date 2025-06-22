#!/bin/sh

ACPI_RES=$(acpi -b)
ACPI_CODE=$?

if [ $ACPI_CODE -eq 0 ]; then
    OUTPUT=""
    INDEX=0

    IFS=$'\n'
    for LINE in $ACPI_RES; do
        BAT_LEVEL=$(echo "$LINE" | grep -oP '\d+(?=%)')
        STATUS=$(echo "$LINE" | grep -oP 'Charging|Discharging|Full')

        if [ -z "$BAT_LEVEL" ]; then
            BAT_LEVEL=0
        fi

        OUTPUT="$OUTPUT BAT$INDEX:$BAT_LEVEL%($STATUS)"
        INDEX=$((INDEX + 1))
    done

    echo "$OUTPUT"
fi

