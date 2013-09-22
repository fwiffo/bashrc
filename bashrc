# ============================================================================
# Author - Tom Schumm <phong@phong.org>
# ============================================================================

# TODO: Skip lots of this stuff if the terminal is dumb or is an
# scp command or whatnot.

# Source global definitions
[ -n "$HOSTNAME" ] || HOSTNAME=`hostname`
BASE_HOSTNAME=${HOSTNAME%%.*}
[ -f ~/.bashkit/gencolors ] && . ~/.bashkit/gencolors

# Shell options
if [ -n "$BASH_VERSINFO" ] && [ ${BASH_VERSINFO[0]} -ge 2 ]; then
    shopt -s extglob
    shopt -s cdspell
fi

# Host specific settings, consider making .bashrc.local for this
if [ -f ~/.bashkit/bashrc.$BASE_HOSTNAME ]; then
    . ~/.bashkit/bashrc.$BASE_HOSTNAME
else
    HCOL=$F_DWHITE
fi

# My users are green
# Admin/root is red
# Other is gray/white
case $USER in
    phong)          UCOL=$F_LGREEN;;
    fwiffo)         UCOL=$F_LGREEN;;
    tom)            UCOL=$F_DGREEN;;
    Tom)            UCOL=$F_DGREEN;;
    tschumm)        UCOL=$F_DGREEN;;
    root)           UCOL=$F_LRED  ;;
    Administrator)  UCOL=$F_DRED  ;;
    admin)          UCOL=$F_DRED  ;;
    *)              UCOL=$F_DWHITE;;
esac

# Environment
#CDPATH=.:$HOME:/

if [ -f ~/.inputrc_$TERM ]; then
    INPUTRC="~/.inputrc_$TERM"
elif [ -f ~/.inputrc ]; then
    INPUTRC=~/.inputrc
elif [ -f /etc/inputrc ]; then
    INPUTRC=/etc/inputrc
fi

if [ "$LANG" == "" ]; then
    LANG=en_US.UTF-8
fi
if [ "$LC_ALL" == "" ]; then
    LC_ALL=en_US.UTF-8
fi
EDITOR="vim"
VISUAL="vim"
PAGER="/usr/bin/less -X -R"
PYTHONSTARTUP="${HOME}/.pythonrc.py"

function setdircolor { # {{{
    # Calculate a few elements/colors of the prompt as things change
    # Background colors for major trees
    case $PWD in
        /usr/local*)  DCOL="$B_LBLACK"  ;;
        /usr*)        DCOL="$B_DBLUE"   ;;
        /var*)        DCOL="$B_DYELLOW" ;;
        /opt*)        DCOL="$B_DMAGENTA";;
        /proc*|/dev*) DCOL="$B_DRED"    ;;
        *)            DCOL=""           ;;
    esac
# Foreground colors for more specific
    case $PWD in
        /sbin*|/usr/sbin*)
                DCOL="$F_LRED$DCOL"     ;;
        /bin*|/usr/bin*|/usr/local/bin*|/opt/bin*)
                DCOL="$F_LGREEN$DCOL"   ;;
        /lib*|/usr/lib*|/usr/local/lib*|/opt/lib*)
                DCOL="$F_DWHITE$DCOL"   ;;
        /usr/include*|/usr/local/include*)
                DCOL="$F_DGREEN$DCOL"   ;;
        /usr/share*|/usr/local/share*)
                DCOL="$F_LMAGENTA$DCOL" ;;
        /usr/src*|/usr/local/src*)
                DCOL="$F_LCYAN$DCOL"    ;;
        /usr/games*|/usr/local/games*|/opt/games*)
                DCOL="$F_DCYAN$DCOL"    ;;
        /boot*) DCOL="$F_DRED$DCOL"     ;;
        /usr/local/*/home*)
                DCOL="$F_LCYAN"         ;;
        /home*) DCOL="$F_LCYAN$DCOL"    ;;
        /Users*)DCOL="$F_LCYAN$DCOL"    ;;
        /root*) DCOL="$F_DYELLOW$DCOL"  ;;
        /etc*)  DCOL="$F_DGREEN$DCOL"   ;;
        /dev*)  DCOL="$F_LYELLOW$DCOL"  ;;
        /proc*) DCOL="$F_LWHITE$DCOL"   ;;
        /mnt*)  DCOL="$F_DCYAN$DCOL"    ;;
        /tmp*|/var/tmp*)
                DCOL="$F_LYELLOW$DCOL"  ;;
#       /usr*|/var*|/opt*)
#               DCOL="$F_LWHITE$DCOL"   ;;
        *)      DCOL="$F_LWHITE$DCOL"   ;;
    esac
} # }}}

function setloadcolor { # {{{
    if [ -f /proc/loadavg ]; then
        local LOAD=`cat /proc/loadavg`
        LOAD=${LOAD%% *}
        LOAD=${LOAD%%.*}${LOAD##*.}
    else
        LOAD=0
    fi
    if [ $NUM_COLORS -ge 256 ]; then
        TCOL=$F_0x21
        if   [ $LOAD -lt  10 ]; then LCOL=$F_0x15
        elif [ $LOAD -lt  20 ]; then LCOL=$F_0x1b
        elif [ $LOAD -lt  30 ]; then LCOL=$F_0x21
        elif [ $LOAD -lt  40 ]; then LCOL=$F_0x27
        elif [ $LOAD -lt  50 ]; then LCOL=$F_0x2d
        elif [ $LOAD -lt  60 ]; then LCOL=$F_0x33
        elif [ $LOAD -lt  70 ]; then LCOL=$F_0x32
        elif [ $LOAD -lt  80 ]; then LCOL=$F_0x31
        elif [ $LOAD -lt  90 ]; then LCOL=$F_0x30
        elif [ $LOAD -lt 100 ]; then LCOL=$F_0x2f
        elif [ $LOAD -lt 110 ]; then LCOL=$F_0x2e
        elif [ $LOAD -lt 120 ]; then LCOL=$F_0x52
        elif [ $LOAD -lt 130 ]; then LCOL=$F_0x76
        elif [ $LOAD -lt 140 ]; then LCOL=$F_0x9a
        elif [ $LOAD -lt 150 ]; then LCOL=$F_0xbe
        elif [ $LOAD -lt 160 ]; then LCOL=$F_0xe2
        elif [ $LOAD -lt 170 ]; then LCOL=$F_0xdc
        elif [ $LOAD -lt 180 ]; then LCOL=$F_0xd6
        elif [ $LOAD -lt 190 ]; then LCOL=$F_0xd0
        elif [ $LOAD -lt 200 ]; then LCOL=$F_0xca
        else                         LCOL=$F_0xc4
        fi
    else
        TCOL=$F_DCYAN
        if   [ $LOAD -lt  10 ]; then LCOL=$F_DBLUE
        elif [ $LOAD -lt  20 ]; then LCOL=$F_LBLUE
        elif [ $LOAD -lt  30 ]; then LCOL=$F_DCYAN
        elif [ $LOAD -lt  50 ]; then LCOL=$F_DGREEN
        elif [ $LOAD -lt  70 ]; then LCOL=$F_LCYAN
        elif [ $LOAD -lt  90 ]; then LCOL=$F_LGREEN
        elif [ $LOAD -lt 110 ]; then LCOL=$F_LYELLOW
        elif [ $LOAD -lt 140 ]; then LCOL=$F_DYELLOW
        elif [ $LOAD -lt 170 ]; then LCOL=$F_DRED
        else                         LCOL=$F_LRED
        fi
    fi
    PWD2=${PWD%/"${PWD##*/}"}
    PWD2=${PWD2##?*/}/${PWD##*/}
    export PY_PS1="${UCOL}>>> ${COLOR_CLEAR}"
    export PY_PS2="${UCOL}... ${COLOR_CLEAR}"
} # }}}

function settitle { # {{{
    case $TERM in
        xterm*|konsole*|rxvt*|eterm*|cygwin*)
            echo -ne "\033]0;$1\007";;
        screen)
            echo -ne "\033_$1\033\\"
    esac
} # }}}

# If they're using screen or an xterm, set the title with each prompt
PROMPT_COMMAND="
    [ \`declare -F setdircolor\` ]  && setdircolor
    [ \`declare -F setloadcolor\` ] && setloadcolor
    [ \`declare -F settitle\` ]     && settitle \"${USER}@${BASE_HOSTNAME}:\${PWD2}\""

# SCOL and LCOL change with every prompt, UCOL and HCOL should not
XL="\[${COLOR_CLEAR}\${LCOL}\]"
XD="\[${COLOR_CLEAR}\${DCOL}\]"
XT="\[${COLOR_CLEAR}\${TCOL}\]"
XU="\[${COLOR_CLEAR}${UCOL}\]"
XH="\[${COLOR_CLEAR}${HCOL}\]"
XC="\[${COLOR_CLEAR}\]"

PS1_line1="${XL}╭━ ${XD}\${PWD}${XL} ◄━━ ${XU}\u${XL}@${XH}\h ${XL}◄━━ ${XT}\d, \A${XL} ◄━━"
PS1_line2="${XL}╰━━► ${XC}"
PS1="\n${PS1_line1}\n${PS1_line2}"
PS2="${XL}╰━━► ${XC}"

export PATH CDPATH INPUTRC EDITOR VISUAL PAGER SHELL PS1 PS2 PS4 PROMPT_COMMAND
export PYTHONSTARTUP HOSTNAME LANG LC_ALL

if   [ -f ~/.dir_colors ]; then
    eval `dircolors -b ~/.dir_colors`
elif [ -f /etc/DIR_COLORS ]; then
    eval `dircolors -b /etc/DIR_COLORS`
fi

# Aliases
if [ -f ~/.bashkit/bash_aliases ]; then
    . ~/.bashkit/bash_aliases
fi
