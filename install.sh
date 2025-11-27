#!/usr/bin/env bash
set -euo pipefail

# Minimal installer: supports --dry-run, --backup, --symlink
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
DRY_RUN=0
BACKUP=0
SYMLINK=0

usage() {
  cat <<EOF
Usage: $0 [--dry-run] [--backup] [--symlink]

Options:
  --dry-run   Show actions without changing files
  --backup    Move existing targets to a timestamped backup
  --symlink   Create symlinks instead of copying
EOF
  exit 1
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --dry-run) DRY_RUN=1; shift ;;
    --backup) BACKUP=1; shift ;;
    --symlink) SYMLINK=1; shift ;;
    -h|--help) usage ;;
    *) echo "Unknown option: $1"; usage ;;
  esac
done

TS="$(date +%Y%m%d%H%M%S)"
BACKUP_DIR="$HOME/.dotfiles_backup_$TS"

# Minimal mapping: repo-name -> destination under $HOME
MAP=(
  "i3:.config/i3"
  "polybar:.config/polybar"
  "kitty:.config/kitty"
  "nvim:.config/nvim"
  "rofi:.config/rofi"
  "dunst:.config/dunst"
  "i3blocks:.config/i3blocks"
  "picom:.config/picom"
  "shell:.config/shell"
  "yazi:.config/yazi"
  ".zshrc:.zshrc"
)

for item in "${MAP[@]}"; do
  name="${item%%:*}"
  dest_rel="${item##*:}"

  # Prefer top-level source, fall back to .config/<name>
  if [ -e "$REPO_DIR/$name" ]; then
    SRC="$REPO_DIR/$name"
  elif [ -e "$REPO_DIR/.config/$name" ]; then
    SRC="$REPO_DIR/.config/$name"
  else
    echo "Skipping missing source: $name"
    continue
  fi

  DST="$HOME/$dest_rel"

  PARENT_DIR="$(dirname "$DST")"

  if [ "$DRY_RUN" -eq 1 ]; then
    echo "DRY RUN: ensure directory: mkdir -p $PARENT_DIR"
    if [ -e "$DST" ]; then
      if [ "$BACKUP" -eq 1 ]; then
        echo "DRY RUN: backup existing $DST -> $BACKUP_DIR/"
      else
        echo "DRY RUN: would remove existing $DST"
      fi
    fi
    if [ "$SYMLINK" -eq 1 ]; then
      echo "DRY RUN: would symlink $DST -> $SRC"
    else
      echo "DRY RUN: would copy $SRC -> $DST"
    fi
    continue
  fi

  mkdir -p "$PARENT_DIR"

  if [ -e "$DST" ] && [ "$BACKUP" -eq 1 ]; then
    mkdir -p "$BACKUP_DIR"
    mv "$DST" "$BACKUP_DIR/"
    echo "Backed up $DST -> $BACKUP_DIR/"
  fi

  rm -rf "$DST"

  if [ "$SYMLINK" -eq 1 ]; then
    ln -sfn "$SRC" "$DST"
    echo "Linked $DST -> $SRC"
  else
    cp -a "$SRC" "$DST"
    echo "Copied $SRC -> $DST"
  fi
done

echo "Done."

exit 0
