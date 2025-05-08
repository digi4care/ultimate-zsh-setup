# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]]; then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Functie om cache te maken of in te laden
alias rcc='refresh_command_cache'
refresh_command_cache() {
  local cache_file="$HOME/.zinit_cmd_cache"
  local commands=(
    git ansible ufw docker docker-compose kubectl kubectx minikube helm nmap node npm nvm rsync screen ssh ssh-agent starship terraform yarn yum brew
  )
  local found_commands=()

  echo "Cache verversen..."

  for cmd in "${commands[@]}"; do
    if command -v "$cmd" >/dev/null 2>&1; then
      found_commands+=("$cmd")
    fi
  done

  printf "%s\n" "${found_commands[@]}" > "$cache_file"
  echo "Cache bijgewerkt met: ${found_commands[*]}"
}
# Add in snippets
# Pad naar cachebestand
CACHE_FILE="$HOME/.zinit_cmd_cache"

# Lijst van commando's om te checken
commands=(
  git ansible ufw docker docker-compose kubectl kubectx minikube helm nmap node npm nvm rsync screen ssh ssh-agent starship terraform yarn yum brew
)

# Functie om cache te maken of in te laden
load_command_cache() {
  if [[ -f "$CACHE_FILE" ]]; then
    # Cache bestaat, laad het in een array
    mapfile -t found_commands < "$CACHE_FILE"
  else
    # Cache bestaat niet, check welke commando's er zijn
    found_commands=()
    for cmd in "${commands[@]}"; do
      if command -v "$cmd" >/dev/null 2>&1; then
        found_commands+=("$cmd")
      fi
    done
    # Schrijf cache weg
    printf "%s\n" "${found_commands[@]}" > "$CACHE_FILE"
  fi
}

# Cache laden of maken
load_command_cache

# Nu laden we de snippets alleen voor gevonden commando's
for cmd in "${found_commands[@]}"; do
  case "$cmd" in
    git)
      zinit snippet OMZL::git.zsh
      zinit snippet OMZP::git
      ;;
    ansible)
      zinit snippet OMZP::ansible
      ;;
    ufw|docker|docker-compose|kubectl|kubectx|minikube|helm|nmap|node|npm|nvm|rsync|screen|ssh|ssh-agent|starship|terraform|yarn|yum|brew)
      zinit snippet OMZP::"$cmd"
      ;;
  esac
done

# Altijd laden, algemene snippets
zinit snippet OMZP::extract
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::encode64
zinit snippet OMZP::command-not-found

# OS-detectie voor Arch Linux en Ubuntu
if [[ -f /etc/arch-release ]]; then
  zinit snippet OMZP::archlinux
elif [[ -f /etc/lsb-release ]] || grep -qi ubuntu /etc/os-release 2>/dev/null; then
  zinit snippet OMZP::ubuntu
fi


# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"