if command -qs systemd
    alias poweroff='systemctl poweroff'
    alias reboot='systemctl reboot'
    alias shutdown='systemctl shutdown'
else
    alias poweroff='loginctl poweroff'
    alias reboot='loginctl reboot'
    alias shutdown='loginctl shutdown'
end

if type -q eza
    alias ls='eza --icons=always'
    alias ll='ls -l'
    alias l='ls --tree --level=1'
    alias la='ls -la'
end

if type -q xsel
    alias copy='xsel -ib'
    alias paste='xsel -ob'
end

type -q bat; and alias cat='bat --style=full'
type -q tmux; and alias t=tmux

alias df='df -h'
alias du='du -h --max-depth=1'
alias lsb='lsblk'
alias ping='ping -c3'
alias up='uptime -p'
