# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"


# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab


# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q




# Load starship theme
# line 1: `starship` binary as command, from github release
# line 2: starship setup at clone(create init.zsh, completion)
# line 3: pull behavior same as clone, source init.zsh
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# Custom starship config location
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml


# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'


# Aliases
alias vim='nvim'
alias cls='clear'

# Function to warn about missing commands
warn_missing() {
  print -P "%F{red}⚠️  Warning: '$1' is not installed. Some features may not work.%f"
}

# exa setup
if command -v exa &> /dev/null; then
    alias ls="exa -lhB@ --icons --color=always --group-directories-first"
    alias l="exa -alh --git --icons --group-directories-first"
    alias ll="exa -lh --icons --group-directories-first"
    alias la="exa -alh --icons --group-directories-first"
    alias lsa="exa -alh --git --icons --group-directories-first"
    alias lt="exa -T --icons --git -L 2"
    alias lsd="exa -lD --icons"
    alias lst="exa -l --sort=modified --icons"
else
    warn_missing exa
    alias ls="ls -lh --color=auto"
    alias l="ls -lah --color=auto"
    alias ll="ls -lh --color=auto"
    alias la="ls -lAh --color=auto"
    alias lsa="ls -AC --group-directories-first -S --color=auto"
fi

# bat setup
if command -v bat &> /dev/null; then
    alias cat="bat --theme=base16-256"
    alias catn="bat -p --theme=base16-256"
else
    warn_missing bat
fi

# fzf warning (optional)
if ! command -v fzf &> /dev/null; then
    warn_missing fzf
fi


# Shell integrations
eval "$(fzf --zsh)"


# Defaults 
export EDITOR=nvim
