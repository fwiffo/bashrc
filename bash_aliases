#!/bin/bash

# Editor behavior
alias vi="vim -o -X"
alias vim="vim -o -X"
alias vimdiff="vimdiff -X"
alias emacs='emacs -nw'

# ls shortcuts
alias d="ls -F --color=always"
alias ll="ls -Fl --color=always"
alias dir="ls -Flh --color=always"
alias dirh="ls -Flha --color=always"

# Disk space
alias dush='du -sh'
alias dus='du -s'
alias duh='du -h'
alias dfh='df -h'

# Misc.
alias less='less -X -R'
alias cls='clear'
alias x='exit'
alias bc='bc -l'
alias chall='chmod -R a+rX'
function mcd {
    mkdir "$@"; cd "$@"
}
function rcd {
    cd `readlink "$@"`
}
alias rebash='source ~/.bashrc'
