# Disable XON/XOFF flow control to free Ctrl-S and Ctrl-Q
stty -ixon

# Zsh opties
setopt AUTO_CD
setopt GLOB_DOTS
setopt EXTENDED_GLOB
setopt APPEND_HISTORY
setopt NO_CASE_GLOB
setopt CORRECT
setopt CORRECT_ALL
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


# Terminfo laden
autoload -Uz zsh/terminfo

# Custom user settings
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase