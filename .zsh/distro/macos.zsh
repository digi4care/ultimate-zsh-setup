# macos.zsh - Homebrew shellenv configuratie

if [[ "$(uname)" == "Darwin" ]] && [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi