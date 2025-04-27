#!/bin/sh

# Icons for volume levels
VOLUME_MUTE="󰖁"
VOLUME_LOW="󰕿"
VOLUME_MID="󰖀"
VOLUME_HIGH="󰕾"

# Get the current volume level and muted status
SOUND_LEVEL=$(amixer -M get Master | awk -F"[][]" '/%/ { print $2 }' | awk -F"%" 'BEGIN{tot=0; i=0} {i++; tot+=$1} END{printf("%s\n", tot/i) }')
MUTED=$(amixer get Master | awk ' /%/{print ($NF=="[off]" ? 1 : 0); exit;}')

# Determine the icon based on volume level and muted status
ICON=$VOLUME_MUTE
if [ "$MUTED" = "1" ]; then
    ICON="$VOLUME_MUTE"
else
    if [ "$SOUND_LEVEL" -lt 34 ]; then
        ICON="$VOLUME_LOW"
    elif [ "$SOUND_LEVEL" -lt 67 ]; then
        ICON="$VOLUME_MID"
    else
        ICON="$VOLUME_HIGH"
    fi
fi

# Mouse scroll actions
case $BLOCK_BUTTON in
    4) # Scroll up: Increase volume
        amixer -q set Master 5%+ ;;
    5) # Scroll down: Decrease volume
        amixer -q set Master 5%- ;;
    1) # Left click: Toggle mute
        amixer -q set Master toggle ;;
esac

# Output the volume status in the desired format
echo "$ICON:$SOUND_LEVEL%"
