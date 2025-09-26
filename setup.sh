#!/bin/bash

echo "🌱 Setting up your Hyprland environment..."

# Install these apps using pacman
sudo pacman -Syu --needed --noconfirm \
  hyprland waybar wofi dunst kitty pavucontrol brightnessctl pcmanfm

# Config folders to link
for folder in hypr waybar wofi dunst kitty pcmanfm; do
  echo "Linking config for: $folder"

  # Delete existing folder if it exists
  rm -rf "$HOME/.config/$folder"

  # Link from your repo to ~/.config
  ln -s "$PWD/$folder" "$HOME/.config/$folder"
done

# Link GTK theme folders if you have them
for ver in 3.0 4.0; do
  if [ -d "gtk-$ver" ]; then
    rm -rf "$HOME/.config/gtk-$ver"
    ln -s "$PWD/gtk-$ver" "$HOME/.config/gtk-$ver"
    echo "Linked gtk-$ver"
  fi
done

# Link extra files if they exist
for file in mimeapps.list pavucontrol.ini; do
  if [ -f "$PWD/$file" ]; then
    ln -sf "$PWD/$file" "$HOME/.config/$file"
    echo "Linked $file"
  fi
done

echo "✅ All done. You can now start Hyprland!"
