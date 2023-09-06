export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(git,docker)

source $ZSH/oh-my-zsh.sh

alias cls=clear
alias p="sudo pacman"
alias lsa="ls -AC --group-directories-first -S"

. "/home/shooty/.wasmedge/env"
