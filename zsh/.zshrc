export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(git,docker)

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

. "/home/shooty/.wasmedge/env"