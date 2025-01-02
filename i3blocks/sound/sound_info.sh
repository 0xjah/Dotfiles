#!/bin/sh

VOLUME_MUTE=" 󰖁 "
VOLUME_LOW=" 󰕿 "
VOLUME_MID=" 󰖀 "
VOLUME_HIGH=" 󰕾 "
SOUND_LEVEL=$(amixer -M get Master | awk -F"[][]" '/%/ { print $2 }' | awk -F"%" 'BEGIN{tot=0; i=0} {i++; tot+=$1} END{printf("%s\n", tot/i) }')
MUTED=$(amixer get Master | awk ' /%/{print ($NF=="[off]" ? 1 : 0); exit;}')

ICON=$VOLUME_MUTE
if [ "$MUTED" = "1" ]
then
    ICON="$VOLUME_MUTE"
else
    if [ "$SOUND_LEVEL" -lt 34 ]
    then
        ICON="$VOLUME_LOW"
    elif [ "$SOUND_LEVEL" -lt 67 ]
    then
        ICON="$VOLUME_MID"
    else
        ICON="$VOLUME_HIGH"
    fi
fi

# Mouse scroll actions
case $BLOCK_BUTTON in
    4) # Scroll up
        amixer -q set Master 5%+ ;;
    5) # Scroll down
        amixer -q set Master 5%- ;;
    1) # Left click to toggle mute
        amixer -q set Master toggle ;;
esac
echo  "$ICON" "$SOUND_LEVEL" | awk '{ printf(" %s:%3s%% \n", $1, $2) }'
