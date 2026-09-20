#!/usr/bin/env bash
# Prompt inside a tmux popup.
# Usage: popup-prompt.sh <initial-text-format> <tmux-command...>
# The input is appended as the last argument of the tmux command.

initial=$(tmux display-message -p "$1")
shift

bind -x '"\e": exit 0' 2>/dev/null
read -rei "$initial" -p "> " input && [[ -n $input ]] || exit 0

output=$(tmux "$@" "$input" 2>&1)
[[ -n $output ]] && tmux display-message "$output"
exit 0
