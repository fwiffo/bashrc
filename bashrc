# vim:sts=4:sw=4
# ============================================================================
# Author - Tom Schumm <phong@phong.org>
# Source this from the end of the .bashrc provided to you by your distro or
# sysadmin to make everything more awesome.
# ============================================================================

# TODO(fwiffo): Skip lots of this stuff if the terminal is dumb or is an
# scp command or whatnot.

# == Initializations that have to run early ======================  # {{{

# Used in prompt and title
[ -n "$HOSTNAME" ] || HOSTNAME=`hostname`
BASE_HOSTNAME=${HOSTNAME%%.*}
USERHOST="$USER@$BASE_HOSTNAME"

# Meh, this will usually be fine
if [ "$TERM" == "screen" ]; then
    TERM=screen-256color
fi

# ================================================================  # }}}

# == Load some helpers ===========================================  # {{{

# Let there be color!
[ -f ~/.bashkit/gencolors ] && . ~/.bashkit/gencolors

if [ $NUM_COLORS -ge 256 ]; then
  source ~/.bashkit/colorize_256.sh
elif [ $NUM_COLORS -ge 16 ]; then
  source ~/.bashkit/colorize_16.sh
else
  source ~/.bashkit/colorize_void.sh
fi

source ~/.bashkit/util.sh

# TODO(fwiffo): Hack, do this better later
PROMPT_COMMAND=""

# Host specific settings, consider making .bashrc.local for this
if [ -f ~/.bashkit/bashrc.$BASE_HOSTNAME ]; then
    . ~/.bashkit/bashrc.$BASE_HOSTNAME
else
    COLOR_HOST=$F_DWHITE
fi

# ================================================================  # }}}

# == Shell options ===============================================  # {{{

shopt -s extglob
shopt -s cdspell

# Options for readline
if [ -f ~/.inputrc_$TERM ]; then
    INPUTRC="~/.inputrc_$TERM"
elif [ -f ~/.inputrc ]; then
    INPUTRC=~/.inputrc
elif [ -f /etc/inputrc ]; then
    INPUTRC=/etc/inputrc
fi

# Use dir colors if available
# TODO(fwiffo): get a nice .dir_colors scheme. The solarized one is a start but
# is kinda crufty and doesn't have all the file types I care about and has some
# nonsense ones in there too
if [ -f ~/.dir_colors ]; then
    eval `dircolors -b ~/.dir_colors`
elif [ -f /etc/DIR_COLORS ]; then
    eval `dircolors -b /etc/DIR_COLORS`
fi

# Make sure our lang stuff is set or everything breaks
if [ "$LANG" == "" ]; then
    LANG=en_US.UTF-8
fi
if [ "$LC_ALL" == "" ]; then
    LC_ALL=en_US.UTF-8
fi

# ================================================================  # }}}

# == Configure a fancy prompt ====================================  # {{{

function set_prompt_vars() { # {{{

    # Find out how much space we have for our prompt
    LEN_PROMPT=160
    if [[ $COLUMNS -lt 160 ]]; then LEN_PROMPT=$COLUMNS; fi

    # Create some abbreviated paths
    LEN_PATH=$(expr $LEN_PROMPT - 3 - 3 - 1 - ${#USERHOST} - 5 - 20 - 4)
    PWD_ELIP=$(ellipsis_path "$PWD" $LEN_PATH)
    PWD_TITLE=$(ellipsis_path "$PWD" $(expr $LEN_PROMPT / 3))

    LEN_BAR=$(expr $LEN_PROMPT - ${#USERHOST} - 30)
    PROMPT_BAR=$(eval printf '─%.0s' {1..$LEN_BAR})

    # Get colors for load and path
    LOAD_AVG=$(get_loadavg)
    C_LOAD=$(get_load_color $LOAD_AVG)
    C_DIR=$(get_dir_color "$PWD")

} # }}}

function prompt_commands() { # {{{

    # Get some information about the current state of the prompt
    set_prompt_vars

    # Set title and a colorized path
    export WINDOW_TITLE="$PWD_TITLE « $USERHOST"
    TITLE_SEQ=`set_title "$WINDOW_TITLE"`
    PWD_COLOR="${COLOR_CLEAR}${C_DIR}${PWD_ELIP}${COLOR_CLEAR}"

} # }}}

# If we didn't set it with a local script
if [[ $PROMPT_COMMAND == "" ]]; then
    PROMPT_COMMAND="prompt_commands"
fi

# Shortcuts to make prompt readable - colors must have \[\] around them so that
# bash is aware that they're zero width; otherwise the prompt will act funny
XL="\[\${C_LOAD}\]"
XT="\[${COLOR_CLOCK}\]"
XU="\[${COLOR_USER}\]"
XH="\[${COLOR_HOST}\]"
XC="\[${COLOR_CLEAR}\]"

PS1_title="\[\${TITLE_SEQ}\]"
PS1_line0="${XL}\${PROMPT_BAR} ${XU}\u${XL}@${XH}\h${XL} ◄── ${XT}\d, \t${XC}${XL} ◄─╯"
PS1_line1="${XL}╭─ \${PWD_COLOR}${XL} ◄──"
PS1_line2="${XL}╰──► ${XC}"

PS1="${PS1_title}${PS1_line0}\\r${PS1_line1}\\n${PS1_line2}"
PS2="${XL}   ╰─► ${XC}"

# ================================================================  # }}}

# == Misc. Environment and Aliases ===============================  # {{{

# My apps of choice
EDITOR="vim"
VISUAL="vim"
PAGER="/usr/bin/less -X -R"
PYTHONSTARTUP="${HOME}/.pythonrc.py"

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

export PATH CDPATH INPUTRC EDITOR VISUAL PAGER SHELL PS1 PS2 PS4 PROMPT_COMMAND
export PYTHONSTARTUP HOSTNAME LANG LC_ALL

# ================================================================  # }}}

