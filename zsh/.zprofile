# Login shells only. macOS runs path_helper from /etc/zprofile, which rebuilds
# PATH with the system directories first; it runs after ~/.zshenv but before
# this file, so Homebrew's prefix has to be prepended here to survive.

typeset -U path PATH

for brew_prefix in /opt/homebrew /usr/local; do
    [[ -x $brew_prefix/bin/brew ]] || continue
    eval "$($brew_prefix/bin/brew shellenv)"
    break
done
unset brew_prefix
