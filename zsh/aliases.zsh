
#            /$$ /$$                                        
#           | $$|__/                                        
#   /$$$$$$ | $$ /$$  /$$$$$$   /$$$$$$$  /$$$$$$   /$$$$$$$
#  |____  $$| $$| $$ |____  $$ /$$_____/ /$$__  $$ /$$_____/
#   /$$$$$$$| $$| $$  /$$$$$$$|  $$$$$$ | $$$$$$$$|  $$$$$$ 
#  /$$__  $$| $$| $$ /$$__  $$ \____  $$| $$_____/ \____  $$
# |  $$$$$$$| $$| $$|  $$$$$$$ /$$$$$$$/|  $$$$$$$ /$$$$$$$/
#  \_______/|__/|__/ \_______/|_______/  \_______/|_______/ 

alias lsa='exa -lahg --git --icons'
alias ls='exa -lhg --git --icons'
alias cp='cp -v'
alias rm='rm -v'
alias mv='mv -v'

# System
alias processes='procs'
alias kernel_version='uname -r'
alias list_devices='lsblk'

# Mount
alias mount='sudo mount'
alias umount='sudo umount'
alias eject='sudo eject'

# System info
alias neofetch='clear && neofetch'
alias pfetch='clear && pfetch'

# Network
alias local_ip="ip addr show | grep 'inet ' | grep -v '127.0.0.1' | awk '{print \$2}'"
alias public_ip="wget -qO- https://ipinfo.io/ip | awk '{print $1}'"

# Nmap
alias list_hosts='sudo nmap -sn'
alias nmap='sudo nmap'

# Wi-Fi
alias wifi_list='nmcli dev wifi list'
alias wifi_connect='nmcli dev wifi connect'

# Weather
alias temperature='curl https://wttr.in/\?format\=1'
alias weather='curl https://wttr.in'

# Yay
alias instally='yes | yay -S'
alias install='yay -S'
alias upgradey=' yes | yay'
alias upgrade='yay'
alias upgrade_aur='yay -Sua'
alias search='yay -Ss'
alias remove_orphaned_packages='yay -Yc'
alias system_health='yay -Ps'

# Git
alias gits='git status'
alias gita='git add'
alias gitall='git add .'
alias gitc='git commit -S'
alias gitl='git log'
alias gitun='git restore --staged'
alias update_origin='git push origin main'

# Utils
alias calc='bc'
alias today='date'
alias calendar='cal'
alias gogh='bash -c  "$(wget -qO- https://git.io/vQgMr)"'
alias manual='tldr'

# Games
alias snake_game='nsnake'

# Funny
alias matrix='unimatrix -n -s 96 -l o'
alias parrot_rainbow='curl parrot.live'
alias parrot_live='curl ascii.live/parrot'

# GPG
alias show_private_key='gpg --export-secret-keys --armor'
alias show_private_key_id='gpg --list-secret-keys --keyid-format LONG'
alias show_public_key='gpg --export --armor'
