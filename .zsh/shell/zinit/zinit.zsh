# shell/zinit.zsh

if [[ ! -d "$HOME/.cache/zinit/completions" ]]; then
  mkdir -p "$HOME/.cache/zinit/completions"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  clone_repo https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Zinit cdreplay plugin
zinit cdreplay -q

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load snippets conditioneel op aanwezigheid commando's
command_exists() {
  which "$1" >/dev/null 2>&1
}

if command_exists git; then
  zinit snippet OMZL::git.zsh
  zinit snippet OMZP::git
fi

if command_exists ansible; then
  zinit snippet OMZP::ansible
fi

for cmd in ufw docker docker-compose kubectl kubectx minikube helm nmap node npm nvm rsync screen ssh ssh-agent starship terraform yarn yum brew; do
  if command_exists "$cmd"; then
    zinit snippet OMZP::"$cmd"
  fi
done

# Algemene snippets altijd laden
zinit snippet OMZP::extract
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::encode64
zinit snippet OMZP::command-not-found

# OS detectie
if [[ -f /etc/arch-release ]]; then
  zinit snippet OMZP::archlinux
elif [[ -f /etc/lsb-release ]] || grep -qi ubuntu /etc/os-release 2>/dev/null; then
  zinit snippet OMZP::ubuntu
fi

# Interactieve shell instellingen
if [[ -o interactive ]]; then
  bindkey -v
  bindkey '^G' autosquash

  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
  zstyle ':completion:*' menu select=1
fi

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Load Powerlevel10k theme
source ${HOME}/.zsh/themes/theme_powerlevel10k.zsh





