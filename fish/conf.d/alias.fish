alias df='df -h'
alias du='du -h --max-depth=0'
alias lsb='lsblk'
alias ping='ping -c3'
alias up='uptime -p'

if grep -iq void /etc/os-release
    alias poweroff='loginctl poweroff'
else
    alias poweroff='systemctl poweroff'
end

if type -q eza
    alias ls='eza --icons=always'
    alias ll='ls -l'
    alias l='ls --tree --level=1'
    alias la='ls -la'
end
type -q bat; and alias cat='bat --style=full'
type -q tmux; and alias t=tmux
