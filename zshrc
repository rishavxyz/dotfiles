###########################################################
# install grml-zsh-config, This file will load after that #
###########################################################

# HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -v

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"

# Decoration for dmenu
export _DMENU_OPTS=('-nb' '#191724' '-nf' '#c4a7e7' '-sb' '#f6c177' '-sf' '#191724' '-p' '' '-fn' 'MonaSans Medium:size=10')

# configs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="/run/user/$UID"
export XDG_DATA_DIRS="/usr/local/share:/usr/share:$HOME/.local/share"
export XDG_CONFIG_DIRS="/etc/xdg"

# PATH
path+=(~/dotfiles/bin ~/projects/go/bin $BUN_INSTALL/bin)
export PATH
