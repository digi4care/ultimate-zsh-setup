# functions.zsh

# Helper functies
command_exists() {
  which "$1" >/dev/null 2>&1
}

file_exists() {
  [[ -f "$1" ]]
}

# Lijst van te zoeken apps
SEARCH_APPS="git ansible ufw docker docker-compose kubectl kubectx minikube helm nmap node npm nvm rsync screen ssh ssh-agent starship terraform yarn yum brew"

# Cache bestand
CACHE_FILE="$HOME/.zinit_cmd_cache"

# Functie om cache te verversen
refresh_command_cache() {
  local commands=($SEARCH_APPS)
  local found_commands=()

  echo "Cache verversen..."

  for cmd in "${commands[@]}"; do
    if command_exists "$cmd"; then
      found_commands+=("$cmd")
    fi
  done

  printf "%s\n" "${found_commands[@]}" > "$CACHE_FILE"
  echo "Cache bijgewerkt met: ${found_commands[*]}"
}

# Functie om cache te laden
load_command_cache() {
  if file_exists "$CACHE_FILE"; then
    mapfile -t found_commands < "$CACHE_FILE"
  else
    found_commands=()
    local commands=($SEARCH_APPS)
    for cmd in "${commands[@]}"; do
      if command_exists "$cmd"; then
        found_commands+=("$cmd")
      fi
    done
    printf "%s\n" "${found_commands[@]}" > "$CACHE_FILE"
  fi
}

# Cache laden bij het starten
load_command_cache

if command_exists git; then

  clone_repo() {
    local repo_url=$1
    local target_dir=$2
    if [[ ! -d "$target_dir" ]]; then
      echo "Cloning $repo_url into $target_dir"
      git clone "$repo_url" "$target_dir"
    else
      echo "Directory $target_dir already exists, skipping clone."
    fi
  }

  update_repo() {
    local target_dir=$1
    if [[ -d "$target_dir" ]]; then
      echo "Updating repository in $target_dir"
      git -C "$target_dir" pull
    else
      echo "Directory $target_dir does not exist, cannot update."
    fi
  }

fi

viewip () {
  sudo netstat -anpl | grep :80 | awk '{print $5}' | cut -d":" -f1 | sort | uniq -c | sort -n | sed -e 's/^ *//' -e 's/ *$//'
}

edit () {
  if command_exists nano; then
    nano -c "$@"
  elif command_exists jpico; then
    jpico -nonotice -linums -nobackups "$@"
  elif command_exists pico; then
    pico "$@"
  else
    nvim "$@"
  fi
}

suedit () {
  if command_exists nano; then
    sudo nano -c "$@"
  elif command_exists jpico; then
    sudo jpico -nonotice -linums -nobackups "$@"
  elif command_exists pico; then
    sudo pico "$@"
  else
    sudo nvim "$@"
  fi
}

hosts () {
  if command_exists nano; then
    sudo nano -c "/etc/hosts"
  elif command_exists jpico; then
    sudo jpico -nonotice -linums -nobackups "/etc/hosts"
  elif command_exists pico; then
    sudo pico "/etc/hosts"
  else
    sudo nvim "/etc/hosts"
  fi
}

extract () {
  for archive in "$@"; do
    if [[ -f $archive ]]; then
      case $archive in
        *.tar.bz2)   tar xvjf "$archive"    ;;
        *.tar.gz)    tar xvzf "$archive"    ;;
        *.bz2)       bunzip2 "$archive"     ;;
        *.rar)       rar x "$archive"       ;;
        *.gz)        gunzip "$archive"      ;;
        *.tar)       tar xvf "$archive"     ;;
        *.tbz2)      tar xvjf "$archive"    ;;
        *.tgz)       tar xvzf "$archive"    ;;
        *.zip)       unzip "$archive"       ;;
        *.Z)         uncompress "$archive"  ;;
        *.7z)        7z x "$archive"        ;;
        *)           echo "don't know how to extract '$archive'..." ;;
      esac
    else
      echo "'$archive' is not a valid file!"
    fi
  done
}

ftext () {
  grep -iIHrn --color=always "$1" . | less -r
}

cpp() {
  set -e
  strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
  | awk '{
    count += $NF
    if (count % 10 == 0) {
      percent = count / total_size * 100
      printf "%3d%% [", percent
      for (i=0;i<=percent;i++)
        printf "="
      printf ">"
      for (i=percent;i<100;i++)
        printf " "
      printf "]\r"
    }
  }
  END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

cpg () {
  if [[ -d "$2" ]]; then
    cp "$1" "$2" && cd "$2"
  else
    cp "$1" "$2"
  fi
}

mvg () {
  if [[ -d "$2" ]]; then
    mv "$1" "$2" && cd "$2"
  else
    mv "$1" "$2"
  fi
}

mkdirg () {
  mkdir -p "$1"
  cd "$1"
}

up () {
  local d=""
  local limit=$1
  for ((i=1 ; i <= limit ; i++)); do
    d=$d/..
  done
  d=$(echo "$d" | sed 's/^\///')
  if [[ -z "$d" ]]; then
    d=..
  fi
  cd "$d"
}

pwdtail () {
  pwd | awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
}

distribution () {
  local dtype="unknown"

  if [[ -r /etc/debian_version ]]; then
    dtype="debian"
  elif [[ -r /etc/redhat-release ]]; then
    dtype="redhat"
  elif [[ -r /etc/SuSE-release ]]; then
    dtype="suse"
  elif [[ -r /etc/gentoo-release ]]; then
    dtype="gentoo"
  elif [[ -r /etc/mandriva-release ]]; then
    dtype="mandriva"
  elif [[ -r /etc/slackware-version ]]; then
    dtype="slackware"
  elif [[ -r /etc/lsb-release ]]; then
    dtype=$(grep DISTRIB_ID /etc/lsb-release | cut -d= -f2 | tr '[:upper:]' '[:lower:]')
  fi
  echo "$dtype"
}

ver () {
  local dtype
  dtype=$(distribution)

  case $dtype in
    redhat)
      if [[ -s /etc/redhat-release ]]; then
        cat /etc/redhat-release && uname -a
      else
        cat /etc/issue && uname -a
      fi
      ;;
    suse)
      cat /etc/SuSE-release
      ;;
    debian)
      lsb_release -a
      ;;
    gentoo)
      cat /etc/gentoo-release
      ;;
    mandriva)
      cat /etc/mandriva-release
      ;;
    slackware)
      cat /etc/slackware-version
      ;;
    *)
      if [[ -s /etc/issue ]]; then
        cat /etc/issue
      else
        echo "Error: Unknown distribution"
        return 1
      fi
      ;;
  esac
}

install_zshrc_support () {
  local dtype
  dtype=$(distribution)

  case "$dtype" in
    redhat)
      sudo yum install multitail tree joe exa bat libnotify-bin nano vi vim pico code net-tools wget fzf zoxide curl
      ;;
    suse)
      sudo zypper install multitail tree joe exa bat libnotify-bin nano vi vim pico code net-tools wget fzf zoxide curl
      ;;
    debian)
      sudo apt-get install multitail tree joe exa bat libnotify-bin nano vi vim pico code net-tools wget fzf zoxide curl
      ;;
    gentoo)
      sudo emerge app-misc/multitail app-text/tree app-editors/joe app-misc/exa app-text/bat sys-apps/dbus app-editors/nano app-editors/vim app-editors/nvi app-editors/pico app-editors/vscodium net-misc/net-tools net-misc/wget app-misc/fzf app-shells/zoxide net-misc/curl
      ;;
    mandriva)
      sudo urpmi multitail tree joe exa bat libnotify-bin nano vi vim pico code net-tools wget fzf zoxide curl
      ;;
    ubuntu)
      sudo apt install multitail tree joe bat libnotify-bin nano vim code net-tools wget fzf zoxide curl
      ;;
    arch)
      sudo pacman -S multitail tree joe exa bat libnotify nano vi vim pico code net-tools wget fzf zoxide curl
      ;;
    fedora)
      sudo dnf install multitail tree joe exa bat libnotify-bin nano vi vim pico code net-tools wget fzf zoxide curl
      ;;
    slackware)
      echo "No install support for Slackware"
      ;;
    *)
      echo "Unknown distribution"
      ;;
  esac
}

netinfo () {
  echo "---- Network Information ----"
  echo "----"
  echo "---- IP Information ----"
  /sbin/ip a | awk /'inet/ {print $2}'
  echo "----"
  echo "---- Broadcast Information ----"
  echo ""
  /sbin/ip a | awk /'brd/ {print $2}'
  echo "----"
  echo "---- Hardware address ----"
  echo ""
  /sbin/ip a | awk /'link\/ether/ {print $2,$4}'
  echo "----"
  echo "---- Link Up/Down ----"
  /sbin/ip a | awk /'state / {print $9}'
  echo "----"
}

whatsmyip () {
  echo -ne "\nExternal IP4: " ; wget https://v4.ident.me -O - -q
  echo -ne "\nExternal IP6: " ; wget https://v6.ident.me -O - -q
}