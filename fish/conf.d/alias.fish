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
