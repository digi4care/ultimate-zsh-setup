# .zshrc

source ~/.zsh/export.zsh
source ~/.zsh/options.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/integrations.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/personal.zsh

if [[ -f /etc/arch-release ]]; then
  source ~/.zsh/distro/archlinux.zsh
fi

if [[ -f /etc/lsb-release ]] || grep -qi ubuntu /etc/os-release 2>/dev/null; then
  source ~/.zsh/distro/ubuntu.zsh
fi

if [[ "$(uname)" == "Darwin" ]]; then
  source ~/.zsh/distro/macos.zsh
fi

# Load completions
autoload -Uz compinit && compinit

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
