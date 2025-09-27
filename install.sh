#!/usr/bin/env bash
set -euo pipefail

# Targets
CONF="$HOME/.config"
BIN="$HOME/.local/bin"
WALL="$HOME/.local/share/wallpapers"

# Backup existing hypr
STAMP="$(date +'%Y-%m-%d_%H-%M-%S')"
if [ -d "$CONF/hypr" ]; then
  mkdir -p "$HOME/backups/hypr/$STAMP"
  tar -C "$CONF" -czf "$HOME/backups/hypr/$STAMP/hypr_backup.tgz" hypr
fi

# Deploy hypr
mkdir -p "$CONF/hypr"
rsync -a --delete ./ "$CONF/hypr/" \
  --exclude ".git" --exclude ".gitignore" --exclude "README.md" --exclude "install.sh" \
  --exclude "scripts" --exclude "wallpapers" --exclude "waybar" --exclude "kitty"

# Deploy scripts
mkdir -p "$BIN"
[ -d "./scripts" ] && rsync -a ./scripts/ "$BIN/"

# Deploy wallpapers
mkdir -p "$WALL"
[ -d "./wallpapers" ] && rsync -a ./wallpapers/ "$WALL/"

# Deploy waybar + kitty
[ -d "./waybar" ] && { mkdir -p "$CONF/waybar"; rsync -a ./waybar/ "$CONF/waybar/"; }
[ -d "./kitty"  ] && { mkdir -p "$CONF/kitty";  rsync -a ./kitty/  "$CONF/kitty/";  }

echo "✅ Deployed hypr, scripts, wallpapers, waybar, kitty"
echo "Tip: ensure swaylock & swayidle are installed, and brightnessctl if you use gamma-level."
