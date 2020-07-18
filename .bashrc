#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s autocd #Allows you to cd into directory merely by typing the directory name.

######## Bash alias ########

# General application alias
alias ls='lsd -A'
alias vifm='${HOME}/.config/vifm/scripts/vifmrun'
alias p='pacman'
alias sp='sudo pacman'
alias spu='sudo pacman -Syu'
alias v='nvim'
alias sudo='sudo '
alias s='sudo '

# Git alias
alias git='LANG=en_GB git ' # Alias to set the default language of git
alias ga='git add '
alias gc='git commit '
alias gcm='git commit -m'
alias gp='git push '
alias gb='git branch '
alias gf='git fetch '
alias gst='git status '

export EDITOR=nvim
export TERM=xterm-termite
export STARSHIP_CONFIG=~/.config/starship/config.toml

######## Prompt settings ########

#PS1='\e[0;31m[\e[m\u@\h \W]\$ '

eval "$(starship init bash)"

# Activating the vi mode in bash
set -o vi

neofetch
