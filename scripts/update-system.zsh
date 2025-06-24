#!/usr/bin/env zsh

# Load color support
autoload -Uz colors && colors

echo "${fg[green]}==> Updating Zinit core...${reset_color}"
zinit self-update

echo "${fg[green]}==> Updating Zinit plugins in parallel (40 jobs)...${reset_color}"
zinit update --parallel 40

echo "\n${fg[green]}==> Updating system packages (pacman)...${reset_color}"
sudo pacman -Syu

if command -v yay >/dev/null 2>&1; then
  echo "\n${fg[green]}==> Updating AUR packages with yay...${reset_color}"
  yay -Syu --devel --timeupdate
elif command -v paru >/dev/null 2>&1; then
  echo "\n${fg[green]}==> Updating AUR packages with paru...${reset_color}"
  paru -Syu --devel --timeupdate
else
  echo "${fg[yellow]}==> No AUR helper (yay or paru) found. Skipping AUR update.${reset_color}"
fi

echo "\n${fg[cyan]}✅ All updates complete!${reset_color}"

