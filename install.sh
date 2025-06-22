#!/bin/bash

# Define source directories
SRC_I3="$HOME/Dotfiles/i3"
SRC_I3BLOCKS="$HOME/Dotfiles/i3blocks"
SRC_KITTY="$HOME/Dotfiles/kitty"
SRC_NEOFETCH="$HOME/Dotfiles/neofetch"
SRC_ROFI="$HOME/Dotfiles/rofi"
SRC_YORHA="$HOME/Dotfiles/yorha-1920x1080"
SRC_ZSHRC="$HOME/Dotfiles/.zshrc"
SRC_BG="$HOME/Dotfiles/wallpaper"

# New added configs
SRC_ALACRITTY="$HOME/Dotfiles/alacritty"
SRC_DUNST="$HOME/Dotfiles/dunst"
SRC_POLYBAR="$HOME/Dotfiles/polybar"
SRC_FASTFETCH="$HOME/Dotfiles/fastfetch"
SRC_GTK="$HOME/Dotfiles/gtk-3.0"
SRC_NVIM="$HOME/Dotfiles/nvim"
SRC_MPV="$HOME/Dotfiles/mpv"

# Define destination directories
DEST_CONFIG="$HOME/.config"
DEST_GRUB="/boot/grub/themes"
DEST_HOME="$HOME"

# Create necessary directories
mkdir -p "$DEST_CONFIG/i3" "$DEST_CONFIG/i3blocks" "$DEST_CONFIG/kitty" "$DEST_CONFIG/neofetch" \
"$DEST_CONFIG/rofi" "$DEST_CONFIG/alacritty" "$DEST_CONFIG/dunst" "$DEST_CONFIG/polybar" \
"$DEST_CONFIG/fastfetch" "$DEST_CONFIG/gtk-3.0" "$DEST_CONFIG/nvim" "$DEST_CONFIG/mpv" \
"$DEST_CONFIG/yazi" "$DEST_HOME/Pictures/wallpapers"

# Since /boot/grub/themes needs root, create with sudo
sudo mkdir -p "$DEST_GRUB"

# Copy function with optional sudo
copy_files() {
    local src=$1
    local dest=$2
    local name=$3
    local use_sudo=$4

    echo "Copying $name..."
    if [[ "$use_sudo" == "true" ]]; then
        if sudo cp -r "$src"/* "$dest"; then
            echo "Successfully copied $name to $dest"
        else
            echo "Error copying $name to $dest"
        fi
    else
        if cp -r "$src"/* "$dest"; then
            echo "Successfully copied $name to $dest"
        else
            echo "Error copying $name to $dest"
        fi
    fi
}

echo "Starting the installation of configuration files..."

copy_files "$SRC_I3" "$DEST_CONFIG/i3" "i3 config" false
copy_files "$SRC_I3BLOCKS" "$DEST_CONFIG/i3blocks" "i3blocks config" false
copy_files "$SRC_KITTY" "$DEST_CONFIG/kitty" "kitty config" false
copy_files "$SRC_NEOFETCH" "$DEST_CONFIG/neofetch" "neofetch config" false
copy_files "$SRC_ROFI" "$DEST_CONFIG/rofi" "rofi config" false
copy_files "$SRC_ALACRITTY" "$DEST_CONFIG/alacritty" "alacritty config" false
copy_files "$SRC_DUNST" "$DEST_CONFIG/dunst" "dunst config" false
copy_files "$SRC_POLYBAR" "$DEST_CONFIG/polybar" "polybar config" false
copy_files "$SRC_FASTFETCH" "$DEST_CONFIG/fastfetch" "fastfetch config" false
copy_files "$SRC_GTK" "$DEST_CONFIG/gtk-3.0" "gtk-3.0 config" false
copy_files "$SRC_NVIM" "$DEST_CONFIG/nvim" "nvim config" false
copy_files "$SRC_MPV" "$DEST_CONFIG/mpv" "mpv config" false
copy_files "$SRC_YORHA" "$DEST_GRUB" "yorha theme" true
copy_files "$SRC_ZSHRC" "$DEST_HOME/.zshrc" ".zshrc" false
copy_files "$SRC_BG" "$DEST_HOME/Pictures/wallpapers" "wallpaper" false

echo "All files have been copied successfully!"

