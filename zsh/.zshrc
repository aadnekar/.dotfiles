# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git emoji)

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_profile


# bun completions
[ -s "/home/aadneka/.bun/_bun" ] && source "/home/aadneka/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun completions
[ -s "/home/adka/.bun/_bun" ] && source "/home/adka/.bun/_bun"
