# personal.zsh

# Ghostty shell integration for Bash. This should be at the top of your bashrc!
if [ -n "${GHOSTTY_RESOURCES_DIR}" ]; then
    builtin source "${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration"
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='nvim'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# deno
export DENO_INSTALL="$HOME/.deno"
add_to_path "$DENO_INSTALL/bin"

# Add deno completions to search path
if [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then export FPATH="$HOME/.zsh/completions:$FPATH"; fi

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
add_to_path "$PNPM_HOME"

# Add additional paths
add_to_path "$HOME/.nvm/versions/node/v22.6.0/bin"
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/.console-ninja/.bin"
add_to_path "$HOME/.config/composer/vendor/bin"
add_to_path "/usr/local/go/bin"
add_to_path "$HOME/go/bin"

# Midnight Commander
# for 8/16 color..
alias mcc="mc -S $HOME/.local/share/mc/skins/dracula.ini"
# for 256 color..
alias mccc="mc -S $HOME/.local/share/mc/skins/dracula256.ini"
. "$HOME/.deno/env"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export TERM=xterm-256color

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Kubernetes docker aliases
alias start_kubectl='docker run --rm -it -v ~/.kube:/root/.kube alpine/k8s:1.24.12 sh'
alias start_kubectl_mount_current_dir='docker run --rm -it -v ~/.kube:/root/.kube -v ./:/apps alpine/k8s:1.24.12 sh'

alias e="windsurf -n ~/.zshrc ~/.zsh/aliases.zsh ~/.zsh/custom.zsh ~/.zsh/distro/ubuntu.zsh ~/.zsh/distro/archlinux.zsh ~/.zsh/exports.zsh ~/.zsh/functions.zsh ~/.zsh/personal.zsh ~/.zsh/plugins.zsh ~/.zsh/tasks.zsh ~/.zsh/themes.zsh"

alias nerd='bash -c  "$(curl -fsSL https://raw.githubusercontent.com/officialrajdeepsingh/nerd-fonts-installer/main/install.sh)"'