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



# PATH
path+=(~/dotfiles/bin ~/projects/go/bin $BUN_INSTALL/bin)
export PATH
