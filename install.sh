#!/usr/bin/env bash
set -eu

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

# Link .zshrc
if [ -e "$REPO_DIR/.zshrc" ]; then
  [ -e "$HOME/.zshrc" ] && mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
  ln -sf "$REPO_DIR/.zshrc" "$HOME/.zshrc"
fi

# Link .config entries
if [ -d "$REPO_DIR/.config" ]; then
  mkdir -p "$HOME/.config"
  for src in "$REPO_DIR/.config"/*; do
    [ -e "$src" ] || continue
    name="$(basename "$src")"
    [ -e "$HOME/.config/$name" ] && mv "$HOME/.config/$name" "$HOME/.config/$name.backup"
    ln -sf "$src" "$HOME/.config/$name"
  done
fi

echo "Done. Run: source ~/.zshrc"