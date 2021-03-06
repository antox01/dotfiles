#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s autocd #Allows you to cd into directory merely by typing the directory name.

######## Bash alias ########

# General application alias
alias ls='lsd -A'
alias p='pacman'
alias sp='sudo pacman'
alias spu='sudo pacman -Syu'
alias v='nvim'
alias vim='nvim'
alias sudo='sudo '
alias s='sudo '

alias tmux='tmux -f ~/.config/tmux/tmux.conf'

alias prj='cd $(fzfdir ~/source/projects)'

# Git alias
alias git='LANG=en_GB git ' # Alias to set the default language of git
alias ga='git add '
alias gc='git commit '
alias gcm='git commit -m'
alias gp='git push '
alias gb='git branch '
alias gf='git fetch '
alias gst='git status '

# get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"


# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion


######## Prompt settings ########

#PS1='\e[0;31m[\e[m\u@\h \W]\$ '

# Check if the prompt is not installed and then install it
[ ! -f "/usr/local/bin/starship" ] && curl -fsSL https://starship.rs/install.sh | bash

eval "$(starship init bash)"

# Activating the vi mode in bash
set -o vi
