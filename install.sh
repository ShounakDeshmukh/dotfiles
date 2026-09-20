#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

if ! command -v stow >/dev/null 2>&1; then
    echo "stow not found. Install it first: brew install stow" >&2
    exit 1
fi

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
mkdir -p "$XDG_CONFIG_HOME"

# zsh reads ~/.zshenv from $HOME before it knows about ZDOTDIR, so this one
# handoff cannot itself be stowed into ~/.config.
if ! grep -qs ZDOTDIR "$HOME/.zshenv"; then
    cat >> "$HOME/.zshenv" <<'ZSHENV'
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
ZSHENV
    echo "wrote ZDOTDIR handoff to ~/.zshenv"
fi

# The repo is one stow package, not one package per subdirectory, so that
# git/config lands at ~/.config/git/config rather than ~/.config/config.
repo="$(pwd)"
stow --dir="$(dirname "$repo")" --target="$XDG_CONFIG_HOME" "$(basename "$repo")"

tpm_dir="$XDG_CONFIG_HOME/tmux/plugins/tpm"
if [[ ! -d $tpm_dir ]]; then
    git clone --depth 1 https://github.com/tmux-plugins/tpm "$tpm_dir"
fi

# Homebrew's completion directories are group-writable, which makes compinit
# refuse to load them and warn on every new shell.
if command -v brew >/dev/null 2>&1; then
    chmod -R go-w "$(brew --prefix)/share/zsh" 2>/dev/null || true
fi

echo "done. open a new shell, then run tmux and hit prefix + I to install plugins."
