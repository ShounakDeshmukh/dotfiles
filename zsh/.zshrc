# Keep PATH free of duplicates; .zshrc re-runs in every nested shell.
typeset -U path PATH

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
if [[ -n $HOMEBREW_PREFIX && -d $HOMEBREW_PREFIX/share/zsh/site-functions ]]; then
    fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)
fi
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
export STARSHIP_CONFIG=${XDG_CONFIG_HOME:-$HOME/.config}/starship/starship.toml

# Transient prompt: once a command is submitted, shrink its prompt to just the arrow.
# The recursive-edit loop keeps Ctrl-C and Ctrl-D behaving normally.
zle-line-init() {
  emulate -L zsh
  [[ $CONTEXT == start ]] || return 0

  while true; do
    zle .recursive-edit
    local -i ret=$?
    [[ $ret == 0 && $KEYS == $'\4' ]] || break
    [[ -o ignore_eof ]] || exit 0
  done

  local saved_prompt=$PROMPT saved_rprompt=$RPROMPT
  PROMPT='%(?.%F{#a6e3a1}.%F{#f38ba8})%B❯%b%f '
  RPROMPT=''
  zle .reset-prompt
  PROMPT=$saved_prompt
  RPROMPT=$saved_rprompt

  if (( ret )); then
    zle .send-break
  else
    zle .accept-line
  fi
  return ret
}
zle -N zle-line-init

#poetry comps

zinit ice pick'poetry.zsh'
zinit light sudosubin/zsh-poetry

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
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -G $realpath'


# Aliases
alias vim='nvim'
alias cls='clear'

# Function to warn about missing commands
warn_missing() {
  print -P "%F{red}Warning: '$1' is not installed. Some features may not work.%f"
}

# eza/exa setup; eza is the maintained fork and what Homebrew ships.
if command -v eza &> /dev/null; then
    ls_bin=eza
elif command -v exa &> /dev/null; then
    ls_bin=exa
fi

if [[ -n ${ls_bin-} ]]; then
    alias ls="$ls_bin -lhB@ --icons --color=always --group-directories-first"
    alias ll="$ls_bin -alh --git --icons --group-directories-first"
    alias l="$ls_bin -lh --icons --group-directories-first"
    alias la="$ls_bin -alh --icons --group-directories-first"
    alias lsa="$ls_bin -alh --git --icons --group-directories-first"
    alias lt="$ls_bin -T --icons --git -L 2"
    alias lsd="$ls_bin -lD --icons"
    alias lst="$ls_bin -l --sort=modified --icons"
    unset ls_bin
else
    warn_missing eza
    alias ls="ls -lhG"
    alias ll="ls -lahG"
    alias l="ls -lhG"
    alias la="ls -lAhG"
    alias lsa="ls -ACSG"
fi

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# bat setup
if command -v bat &> /dev/null; then
    alias catn="bat --theme=base16-256"
else
    warn_missing bat
fi



# Shell integrations
if command -v fzf &> /dev/null; then
    eval "$(fzf --zsh)"
else
    warn_missing fzf
fi


# Defaults 
export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"
