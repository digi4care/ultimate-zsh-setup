# Standard aliases

# Colors for grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Alert alias
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history | tail -n1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Edit this .zshrc file
alias ebrc='edit ~/.zshrc'
alias hlp='man zsh_aliases'

# Date alias
alias da='date "+%Y-%m-%d %A %T %Z"'

# Modified commands
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -iv'
alias mkdir='mkdir -p'
alias ps='ps auxf'
alias ping='ping -c 10'
alias less='less -R'
alias cls='clear'
alias multitail='multitail --no-repeat -c'
alias vi='vim'
alias svi='sudo vi'
alias vis='vim "+set si"'

alias x="exit"
alias r="source ~/.zshrc"

# apt commands (OS specific)
alias updateall='sudo -- sh -c "apt update && apt upgrade && apt auto-remove"'
alias sapt='sudo apt'
alias sapti='sudo apt install'
alias saptr='sudo apt remove'
alias saptg='sudo apt-get'

# Directory navigation
# alias cd='zoxide'
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias bd='cd "$OLDPWD"'

# Remove directory recursively
alias rmd='/bin/rm --recursive --force --verbose'

# chmod shortcuts
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# History search
alias h="history | grep"
alias ag="alias | grep "
alias p="ps aux | grep"
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"
alias f="find . | grep"

# Count files, links, directories
alias countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"

# Check command type
alias checkcommand="type -t"

# Network aliases
alias openports='sudo netstat -nape --inet'
alias ports='netstat -tulanp'

# Reboot aliases
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'

# Disk space aliases
alias diskspace="du -S | sort -n -r | more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias treebare='tree'
alias mountedinfo='df -hT'

# Archive aliases
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# Logs
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e 's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

# OpenSSL digest aliases
alias md5='openssl dgst -md5'
alias sha1='openssl dgst -sha1'
alias sha224='openssl dgst -sha224'
alias sha256='openssl dgst -sha256'
alias sha384='openssl dgst -sha384'
alias sha512='openssl dgst -sha512'
alias sha3-224='openssl dgst -sha3-224'
alias sha3-256='openssl dgst -sha3-256'
alias sha3-384='openssl dgst -sha3-384'
alias sha3-512='openssl dgst -sha3-512'
alias blake2b512='openssl dgst -blake2b512'
alias blake2s256='openssl dgst -blake2s256'
alias ripemd160='openssl dgst -ripemd160'
alias whirlpool='openssl dgst -whirlpool'

# Image optimizer
alias iow="npx @squoosh/cli --webp auto "
alias ioa="npx @squoosh/cli --avif auto "
alias iop="npx @squoosh/cli --oxipng auto "

alias freshclam='sudo freshclam'

# Directory listing with eza
alias la='eza -al --long --header --group-directories-first'
alias ls='eza -a --classify --color=always --group-directories-first'
alias lx='eza -al --long --header --group-directories-first --sort=extension'
alias lk='eza -al --long --header --group-directories-first --sort=size --reverse'
alias lc='eza -al --long --header --group-directories-first --sort=changed --reverse'
alias lu='eza -al --long --header --group-directories-first --sort=accessed --reverse'
alias lr='eza -al --long --header --group-directories-first --recurse'
alias lt='eza -al --long --header --group-directories-first --sort=modified --reverse'
alias lm='eza -al --long --header --group-directories-first | more'
alias lw='eza -al --long --header --group-directories-first --grid --across'
alias ll='eza -al --long --header --group-directories-first'
alias labc='eza -al --long --header --group-directories-first --sort=alphabetical'
alias lf="eza -al --long --header --group-directories-first --no-dirs"
alias ldir="eza -al --long --header --group-directories-first --dirs-only"

# Batcat aliases
alias cat='batcat --style=plain'
alias bat='batcat --paging=always'
alias batn='batcat --style=plain --number'
alias batc='batcat --color=always'
alias bath='batcat --highlight-line'
alias batp='batcat --plain'
alias batl='batcat --list-languages'
alias batf='batcat --file'
alias batnn='batcat --style=plain --paging=always --color=always'