#!/bin/bash

# Define source directories
SRC_I3="$HOME/Dotfiles/i3"
SRC_KITTY="$HOME/Dotfiles/kitty"
SRC_NEOFETCH="$HOME/Dotfiles/neofetch"
SRC_NVIM="$HOME/Dotfiles/nvim"
SRC_PICOM="$HOME/Dotfiles/picom"
SRC_ROFI="$HOME/Dotfiles/rofi"
SRC_YORHA="$HOME/Dotfiles/yorha-1920x1080"
SRC_TMUX="$HOME/Dotfiles/.tmux"
SRC_ZSHRC="$HOME/Dotfiles/.zshrc"
SRC_BG="$HOME/Dotfiles/wallpaper.jpg"

# Define destination directories
DEST_CONFIG="$HOME/.config"
DEST_GRUB="/boot/grub/themes"
DEST_HOME="$HOME"

# Create necessary directories if they don't exist
mkdir -p "$DEST_CONFIG/i3"
mkdir -p "$DEST_CONFIG/kitty"
mkdir -p "$DEST_CONFIG/neofetch"
mkdir -p "$DEST_CONFIG/nvim"
mkdir -p "$DEST_CONFIG/picom"
mkdir -p "$DEST_CONFIG/rofi"
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
copy_files "$SRC_KITTY" "$DEST_CONFIG/kitty" "kitty config"
copy_files "$SRC_NEOFETCH" "$DEST_CONFIG/neofetch" "neofetch config"
copy_files "$SRC_NVIM" "$DEST_CONFIG/nvim" "nvim config"
copy_files "$SRC_PICOM" "$DEST_CONFIG/picom" "picom config"
copy_files "$SRC_ROFI" "$DEST_CONFIG/rofi" "rofi config"
copy_files "$SRC_YORHA" "$DEST_GRUB" "yorha theme"
copy_files "$SRC_TMUX" "$DEST_HOME/.tmux" ".tmux"
copy_files "$SRC_ZSHRC" "$DEST_HOME/.zshrc" ".zshrc"
copy_files "$SRC_BG" "$DEST_HOME/Pictures" "wallpaper.jpg "
echo "All files have been copied successfully!"

