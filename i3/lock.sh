#!/bin/bash
# Lock Script - Lain Vibe v2

rm -f /tmp/screen*

# Take screenshot
scrot /tmp/screen.png

# Apply Lain-style effects to screenshot only (grayscale etc)
magick /tmp/screen.png \
    -resize 1920x1080\! \
    -blur 0x1.5 \
    -swirl 666 \
    -attenuate 0.4 +noise Laplacian \
    -modulate 70,130 \
    /tmp/screen_effect.png

# Optional glitch overlay on effects
if [[ -f ~/.config/i3/glitch_overlay.png ]]; then
    magick /tmp/screen_effect.png ~/.config/i3/glitch_overlay.png -compose overlay -composite /tmp/screen_effect.png
fi

# Convert grayscale image to 3-channel RGB explicitly (remove grayscale)
magick /tmp/screen_effect.png -type TrueColor /tmp/screen_color.png

# Composite colored lock1.png over it
if [[ -f ~/.config/i3/lock1.png ]]; then
    magick /tmp/screen_color.png ~/.config/i3/lock1.png -gravity center -compose over -composite /tmp/screen.png
else
    cp /tmp/screen_color.png /tmp/screen.png
fi

# Lock the screen with final image
i3lock -e -f -c 000000 -i /tmp/screen.png

