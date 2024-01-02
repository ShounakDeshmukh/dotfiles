export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(git docker)

source $ZSH/oh-my-zsh.sh

alias cls=clear
alias p="sudo pacman"

if command -v exa &> /dev/null
then
    alias ls="exa -lhB@ --icons --color always --group-directories-first"
    alias lsa="exa -lhB@a --icons --color always --group-directories-first" 
else
    alias lsa="ls -AC --group-directories-first -S"
fi

if command -v bat &> /dev/null
then
    alias cat="bat --theme=base16-256"
    alias catn="bat -p --theme=base16-256" 
fi


export TERM=alacritty
#. "/home/shooty/.wasmedge/env"
#if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#  exec tmux
#fi
#
