#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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

#PS1='\e[0;31m[\e[m\u@\h \W]\$ '

######## Prompt settings ########

# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        STAT=`parse_git_dirty`
        echo " [${BRANCH}${STAT}$(tput setaf 2)]"
    else
        echo ""
    fi
}

# get current status of git repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
        bits=" >${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
        bits=" $(tput bold)$(tput setaf 7)⬆$(tput sgr0)${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
        bits=" $(tput setaf 15)✔$(tput sgr0)${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
        bits=" $(tput bold)$(tput setaf 1)?$(tput sgr0)${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
        bits=" x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
        bits=" $(tput setaf 11)✎${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
        echo "${bits}"
    else
        echo ""
    fi
}

# Simple prompt that can display git information
export PS1="\[$(tput bold)$(tput setaf 4)\]\w\[\e[m\]\[$(tput setaf 2)\]\`parse_git_branch\`\[\e[m\] \[$(tput setaf 14)\]>\[\e[m\] "

# Powerline-shell
#function _update_ps1() {
#	PS1=$(powerline-shell $?)
#}
#
#if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
#	PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#fi

# Activating the vi mode in bash
set -o vi

export EDITOR=nvim
export TERM=xterm-termite

neofetch
