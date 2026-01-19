#!/bin/bash
# Optimized Lock Script - Lain Vibe v2

# Single ImageMagick command chain - no intermediate files
scrot -o /tmp/screen.png

# Build composite command based on available overlays
CONVERT_CMD="magick /tmp/screen.png -resize 1920x1080! -blur 0x1.5 -swirl 666 +noise Laplacian -attenuate 0.4 -modulate 70,130"

[[ -f ~/.config/i3/glitch_overlay.png ]] && CONVERT_CMD+=" ~/.config/i3/glitch_overlay.png -compose overlay -composite"
[[ -f ~/.config/i3/lock1.png ]] && CONVERT_CMD+=" ~/.config/i3/lock1.png -gravity center -compose over -composite"

# Execute single pipeline
eval "$CONVERT_CMD /tmp/screen.png"

# Lock immediately
i3lock -efn -i /tmp/screen.png &

# Cleanup in background
(sleep 1; rm -f /tmp/screen.png) &
