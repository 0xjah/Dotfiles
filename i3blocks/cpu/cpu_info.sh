#!/bin/sh

# Get CPU temp
if command -v sensors &> /dev/null; then
    TEMP=$(sensors | grep 'Package id 0:\|Tdie' | grep -o '+[0-9]*\.[0-9]*°C' | head -n 1)
else
    TEMP="N/A°C"
fi

# Get CPU usg
if command -v mpstat &> /dev/null; then
    CPU_USAGE=$(mpstat 1 1 | awk '/all/ {printf("%.2f%%\n", 100 - $NF); exit}')
else
    CPU_USAGE="N/A"
fi

if (( $(echo "$CPU_USAGE > 90" | bc -l) )); then
    COLOR="#FF0000" # Red for critical usage
elif (( $(echo "$CPU_USAGE > 70" | bc -l) )); then
    COLOR="#FFFF00" # Yellow for high usage
else
    COLOR="#00FF00" # Green for normal usage
fi

echo "<span color='$COLOR'>CPU: $CPU_USAGE @ $TEMP</span>"
