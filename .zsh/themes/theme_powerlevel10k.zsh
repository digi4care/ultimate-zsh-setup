

# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Powerlevel10k theme setup
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Source Powerlevel10k config if exists
[[ -f ~/.zsh/themes/powerlevel10k.zsh ]] && source ~/.zsh/themes/powerlevel10k.zsh