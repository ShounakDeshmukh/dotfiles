# dotfiles

macOS config, managed with GNU stow. The Linux/Hyprland setup lives on the `linux` branch.

Colorscheme: [Catppuccin](https://github.com/catppuccin/catppuccin) Mocha throughout.

## Install

```sh
git clone git@github.com:ShounakDeshmukh/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` is safe to re-run. It writes the `ZDOTDIR` handoff into `~/.zshenv`,
stows the repo into `~/.config`, and clones tpm.

Then open a new shell, start `tmux`, and hit `prefix + I` to install the tmux plugins.

## Dependencies

```sh
brew install stow tmux neovim fzf eza bat
brew install --cask ghostty font-0xproto-nerd-font
```

The Nerd Font is required: starship and tmux both render glyph icons, and zed is
configured to use 0xProto. Everything else the shell needs (starship, syntax
highlighting, completions, fzf-tab) is fetched by zinit on first shell start.

## Layout

Everything stows into `~/.config`:

| package    | lands at                       |
|------------|--------------------------------|
| `zsh/`     | `~/.config/zsh` (via `ZDOTDIR`) |
| `tmux/`    | `~/.config/tmux`               |
| `starship/`| `~/.config/starship`           |
| `git/`     | `~/.config/git`                |
| `zed/`     | `~/.config/zed`                |
| `ghostty/` | `~/.config/ghostty`            |

The repo is stowed as a **single** package, not one package per subdirectory -
`stow */` would flatten `git/config` to `~/.config/config`. `install.sh` gets
this right; `.stow-local-ignore` keeps the repo's own files out of `~/.config`.
