#!/bin/bash

# Define source directories
SRC_I3="$HOME/Dotfiles/i3"
SRC_I3BLOCKS="$HOME/Dotfiles/i3blocks"
SRC_KITTY="$HOME/Dotfiles/kitty"
SRC_NEOFETCH="$HOME/Dotfiles/neofetch"
SRC_ROFI="$HOME/Dotfiles/rofi"
SRC_YORHA="$HOME/Dotfiles/yorha-1920x1080"
SRC_ZSHRC="$HOME/Dotfiles/.zshrc"
SRC_BG="$HOME/Dotfiles/wallpaper/"

# Define destination directories
DEST_CONFIG="$HOME/.config"
DEST_GRUB="/boot/grub/themes"
DEST_HOME="$HOME"

# Create necessary directories if they don't exist
mkdir -p "$DEST_CONFIG/i3"
mkdir -p "$DEST_CONFIG/i3blocks"
mkdir -p "$DEST_CONFIG/kitty"
mkdir -p "$DEST_CONFIG/neofetch"
mkdir -p "$DEST_CONFIG/rofi"
mkdir -p "$DEST_CONFIG/yazi"
mkdir -p "$DEST_GRUB"
mkdir -p "$DEST_HOME/Pictures"

# Function to copy files with a message
copy_files() {
    local src=$1
    local dest=$2
    local name=$3

    echo "Copying $name..."
    if cp -r "$src"/* "$dest"; then
        echo "Successfully copied $name to $dest"
    else
        echo "Error copying $name to $dest"
    fi
}

# Start copying files
echo "Starting the installation of configuration files..."

copy_files "$SRC_I3" "$DEST_CONFIG/i3" "i3 config"
copy_files "$SRC_I3BLOCKS" "$DEST_CONFIG/i3blocks" "i3blocks config"
copy_files "$SRC_KITTY" "$DEST_CONFIG/kitty" "kitty config"
copy_files "$SRC_NEOFETCH" "$DEST_CONFIG/neofetch" "neofetch config"
copy_files "$SRC_ROFI" "$DEST_CONFIG/rofi" "rofi config"
copy_files "$SRC_YORHA" "$DEST_GRUB" "yorha theme"
copy_files "$SRC_ZSHRC" "$DEST_HOME/.zshrc" ".zshrc"
copy_files "$SRC_BG" "$DEST_HOME/wallpaper" "wallpaper "
echo "All files have been copied successfully!"

