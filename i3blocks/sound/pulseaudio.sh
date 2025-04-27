#!/bin/sh

VOLUME_MUTE="󰖁"
VOLUME_LOW="󰕿"
VOLUME_MID="󰖀"
VOLUME_HIGH="󰕾"

SOUND_LEVEL=$(amixer get Master | grep -oP '\d+(?=%)' | head -n 1)
MUTED=$(amixer get Master | awk ' /%/{print ($NF=="[off]" ? 1 : 0); exit;}')

SOUND_LEVEL=$(echo "$SOUND_LEVEL" | tr -d '[:space:]')

case $BLOCK_BUTTON in
    4)
        amixer -q set Master 5%+ unmute
        ;;
    5)
        amixer -q set Master 5%- unmute
        ;;
    1)
        amixer -q set Master toggle
        ;;
esac

SOUND_LEVEL=$(amixer get Master | grep -oP '\d+(?=%)' | head -n 1)
MUTED=$(amixer get Master | awk ' /%/{print ($NF=="[off]" ? 1 : 0); exit;}')
SOUND_LEVEL=$(echo "$SOUND_LEVEL" | tr -d '[:space:]')

VOLUME_NORMALIZED=$((SOUND_LEVEL / 10))

if [ "$MUTED" = "1" ]; then
    ICON="$VOLUME_MUTE"
    RAMP="┤──────────"
else
    case $VOLUME_NORMALIZED in
        0) ICON="$VOLUME_LOW"; RAMP="┤──────────" ;;
        1) ICON="$VOLUME_LOW"; RAMP="─┤─────────" ;;
        2) ICON="$VOLUME_LOW"; RAMP="──┤────────" ;;
        3) ICON="$VOLUME_LOW"; RAMP="───┤───────" ;;
        4) ICON="$VOLUME_MID"; RAMP="────┤──────" ;;
        5) ICON="$VOLUME_MID"; RAMP="─────┤─────" ;;
        6) ICON="$VOLUME_MID"; RAMP="──────┤────" ;;
        7) ICON="$VOLUME_HIGH"; RAMP="───────┤───" ;;
        8) ICON="$VOLUME_HIGH"; RAMP="────────┤──" ;;
        9) ICON="$VOLUME_HIGH"; RAMP="─────────┤─" ;;
        10) ICON="$VOLUME_HIGH"; RAMP="──────────┼" ;;
        *) ICON="$VOLUME_LOW"; RAMP="┤──────────" ;;
    esac
fi

echo "$ICON :$SOUND_LEVEL"
echo "$ICON :$SOUND_LEVEL"
if [ "$MUTED" = "1" ]; then
    echo "#FF0000"
elif [ "$VOLUME_NORMALIZED" -ge 8 ]; then
    echo "#00FF00"
else
    echo "#FFFFFF"
fi
