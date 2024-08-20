# HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -v

# PATH
path+=("$HOME/dotfiles/bin")
export PATH
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# aliases
alias cat=bat
alias df='df -h'
alias du='du -h'
alias lsb='lsblk'
