#!/usr/bin/env bash
#
# Improved Dotfiles installer
# Features:
#  - safe defaults (backup)
#  - dry-run mode
#  - symlink or copy options
#  - simple distro detection and guidance
#
set -euo pipefail
IFS=$'\n\t'

PROGNAME="$(basename "$0")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOGFILE="/tmp/dotfiles-install.log"
TIMESTAMP="$(date +%Y%m%dT%H%M%S)"
BACKUP_DIR="$HOME/.dotfiles_backup_$TIMESTAMP"

DRY_RUN=false
DO_BACKUP=false
USE_SYMLINKS=false
FORCE=false
VERBOSE=true

# List of mappings: source relative path -> destination absolute path
declare -A MAPS

# Populate default maps (adjust as repo layout requires)
MAPS["i3"]="$HOME/.config/i3"
MAPS["i3blocks"]="$HOME/.config/i3blocks"
MAPS["kitty"]="$HOME/.config/kitty"
MAPS["alacritty"]="$HOME/.config/alacritty"
MAPS["neofetch"]="$HOME/.config/neofetch"
MAPS["fastfetch"]="$HOME/.config/fastfetch"
MAPS["polybar"]="$HOME/.config/polybar"
MAPS["dunst"]="$HOME/.config/dunst"
MAPS["nvim"]="$HOME/.config/nvim"
MAPS["mpv"]="$HOME/.config/mpv"
MAPS["rofi"]="$HOME/.config/rofi"
MAPS["gtk-3.0"]="$HOME/.config/gtk-3.0"
MAPS[".zshrc"]="$HOME/.zshrc"
MAPS["wallpapers"]="$HOME/Pictures/wallpapers"
MAPS["hollow-knight-grub-theme"]="/boot/grub/themes/hollow-knight-grub-theme"

print() {
    if [ "$VERBOSE" = true ]; then
        echo "$@"
    fi
    echo "$(date --iso-8601=seconds) $*" >> "$LOGFILE"
}

usage() {
    cat <<EOF
Usage: $PROGNAME [options]

Options:
  --dry-run        : Show what would be done without making changes
  --backup         : Create timestamped backup of existing files
  --symlink        : Create symlinks instead of copying files
  --force          : Overwrite without creating backups
  --quiet          : Minimal output
  -h|--help        : Show this help
EOF
    exit 1
}

# Simple argument parse
while [ "$#" -gt 0 ]; do
    case "$1" in
        --dry-run) DRY_RUN=true; shift ;;
        --backup) DO_BACKUP=true; shift ;;
        --symlink) USE_SYMLINKS=true; shift ;;
        --force) FORCE=true; shift ;;
        --quiet) VERBOSE=false; shift ;;
        -h|--help) usage ;;
        *) echo "Unknown option: $1"; usage ;;
    esac
done

# Ensure log file exists
: > "$LOGFILE"

# Distro detection (informational)
if [ -r /etc/os-release ]; then
    . /etc/os-release
    DISTRO_NAME="$NAME"
    DISTRO_ID="$ID"
else
    DISTRO_NAME="Unknown"
    DISTRO_ID="unknown"
fi
print "Detected distro: $DISTRO_NAME ($DISTRO_ID)"

# Dry-run helper
run_cmd() {
    if [ "$DRY_RUN" = true ]; then
        print "[DRY-RUN] $*"
    else
        eval "$@"
    fi
}

# Backup helper
backup_target() {
    local target="$1"
    if [ -e "$target" ] && [ "$FORCE" = false ]; then
        mkdir -p "$BACKUP_DIR"
        print "Backing up $target -> $BACKUP_DIR/"
        if [ "$DRY_RUN" = false ]; then
            cp -a --parents "$target" "$BACKUP_DIR/" || true
        fi
    fi
}

install_item() {
    local src_rel="$1"
    local dest="$2"

    local src="$SCRIPT_DIR/$src_rel"

    if [ ! -e "$src" ]; then
        print "Skipping: source not found: $src"
        return
    fi

    # If destination is within /boot or other root-owned path, mark requires_sudo
    local requires_sudo=false
    if [[ "$dest" == /boot/* || "$dest" == /etc/* ]]; then
        requires_sudo=true
    fi

    # Prepare target directory
    local parent_dir
    parent_dir="$(dirname "$dest")"
    if [ "$DRY_RUN" = false ]; then
        if [ "$requires_sudo" = true ]; then
            sudo mkdir -p "$parent_dir"
        else
            mkdir -p "$parent_dir"
        fi
    else
        print "[DRY-RUN] mkdir -p $parent_dir"
    fi

    # Backup existing target if needed
    if [ "$DO_BACKUP" = true ] && [ -e "$dest" ]; then
        backup_target "$dest"
    fi

    # Remove existing target if force is used
    if [ -e "$dest" ] && [ "$FORCE" = true ]; then
        print "Removing existing: $dest (force)"
        if [ "$DRY_RUN" = false ]; then
            if [ "$requires_sudo" = true ]; then
                sudo rm -rf "$dest"
            else
                rm -rf "$dest"
            fi
        fi
    fi

    # Install (symlink or copy)
    if [ "$USE_SYMLINKS" = true ]; then
        print "Linking $src -> $dest"
        if [ "$DRY_RUN" = false ]; then
            if [ "$requires_sudo" = true ]; then
                sudo ln -sfn "$src" "$dest"
            else
                ln -sfn "$src" "$dest"
            fi
        fi
    else
        print "Copying $src -> $dest"
        if [ "$DRY_RUN" = false ]; then
            if [ "$requires_sudo" = true ]; then
                sudo cp -a "$src" "$dest"
            else
                cp -a "$src" "$dest"
            fi
        fi
    fi
}

print "Starting installation at $(date --iso-8601=seconds)"
for key in "${!MAPS[@]}"; do
    src_rel="$key"
    dest="${MAPS[$key]}"
    install_item "$src_rel" "$dest"
done

print "Installation finished. Log: $LOGFILE"

print "Summary / next steps:"
print " - If you installed a GRUB theme, regenerate grub configuration (example):"
print "     sudo update-grub  # Debian/Ubuntu"
print "     sudo grub-mkconfig -o /boot/grub/grub.cfg  # Arch"
print " - To apply shell changes: source ~/.zshrc or open a new session"
print " - To restart i3: i3-msg restart"

exit 0
