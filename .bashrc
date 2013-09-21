# ~/.bashrc
# vim:ts=4:sw=4:noet:
# =================================================================
# Fancy .bashrc designed to make things alike on all the systems I
# use.
# (C) 2005 Thomas Schumm (visit http://www.phong.org)
#
# This file is sourced by all bash shells on startup, whether
# interactive or not.  This file *should generate no output* or it
# will break the scp and rcp commands.
# =================================================================

# TODO: Skip lots of this stuff if the terminal is dumb or is an
# scp command or whatnot.

# Source global definitions
[ -n "$HOSTNAME" ] || HOSTNAME=`hostname`
BASE_HOSTNAME=${HOSTNAME%%.*}
#[ -f /etc/bashrc ] && [ "$HOSTNAME" != 'beta.e-mol.com' ] && . /etc/bashrc
[ -f ~/.profile ] && . ~/.profile
[ -f /etc/profile.d/bash-completion ] && . /etc/profile.d/bash-completion
[ -f /etc/bash-completion ] && . /etc/bash-completion
[ -f ~/.env/gencolors.sh ] && . ~/.env/gencolors.sh

# Shell options
if [ -n "$BASH_VERSINFO" ] && [ ${BASH_VERSINFO[0]} -ge 2 ]; then
	shopt -s extglob
	shopt -s cdspell
fi

# Host specific settings, consider making .bashrc.local for this
if [ -f ~/.env/bashrc.$BASE_HOSTNAME ]; then
	. ~/.env/bashrc.$BASE_HOSTNAME
else
	HCOL=$F_DWHITE
fi

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

# Calculate a few elements/colors of the prompt as things change
function setdircolor {
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
		/usr/portage*|/usr/local/portage*)
				DCOL="$F_LYELLOW$DCOL"  ;;
		/usr/include*|/usr/local/include*)
				DCOL="$F_DGREEN$DCOL"   ;;
		/usr/share*|/usr/local/share*)
				DCOL="$F_LMAGENTA$DCOL" ;;
		/usr/src*|/usr/local/src*)
				DCOL="$F_LCYAN$DCOL"    ;;
		/usr/games*|/usr/local/games*|/opt/games*)
				DCOL="$F_DCYAN$DCOL"    ;;
		/boot*) DCOL="$F_DRED$DCOL"     ;;
		/home*) DCOL="$F_LCYAN$DCOL"    ;;
		/root*) DCOL="$F_DYELLOW$DCOL"  ;;
		/etc*)  DCOL="$F_DGREEN$DCOL"   ;;
		/dev*)  DCOL="$F_LYELLOW$DCOL"  ;;
		/proc*) DCOL="$F_LWHITE$DCOL"   ;;
		/mnt*)  DCOL="$F_DCYAN$DCOL"    ;;
		/tmp*|/var/tmp*)
				DCOL="$F_LYELLOW$DCOL"  ;;
#		/usr*|/var*|/opt*)
#				DCOL="$F_LWHITE$DCOL"   ;;
		*)      DCOL="$F_LWHITE$DCOL"   ;;
	esac
}

function setloadcolor {
	local LOAD=`cat /proc/loadavg`
# LOAD=`echo -n ${LOAD%% *} 100\*p|dc`
# LOAD=${LOAD%%.*}
	LOAD=${LOAD%% *}
	LOAD=${LOAD%%.*}${LOAD##*.}
	if   [ $LOAD -lt  10 ]; then  LCOL=$F_DBLUE
	elif [ $LOAD -lt  20 ]; then  LCOL=$F_LBLUE
	elif [ $LOAD -lt  30 ]; then  LCOL=$F_DCYAN
	elif [ $LOAD -lt  50 ]; then  LCOL=$F_DGREEN
	elif [ $LOAD -lt  70 ]; then  LCOL=$F_LCYAN
	elif [ $LOAD -lt  90 ]; then  LCOL=$F_LGREEN
	elif [ $LOAD -lt 110 ]; then  LCOL=$F_LYELLOW
	elif [ $LOAD -lt 140 ]; then  LCOL=$F_DYELLOW
	elif [ $LOAD -lt 170 ]; then  LCOL=$F_DRED
	else                          LCOL=$F_LRED
	fi
	if [ ! -O . ]; then
		SCOL="$SCOL0"
	else
		SCOL="$SCOL1"
	fi
	PWD2=${PWD%/"${PWD##*/}"}
	PWD2=${PWD2##?*/}/${PWD##*/}
	export PY_PS1="${SCOL}>>> ${COLOR_CLEAR}"
	export PY_PS2="${SCOL}... ${COLOR_CLEAR}"
}

function settitle {
	case $TERM in
		xterm*|konsole*|rxvt*|eterm*|cygwin*)
			echo -ne "\033]0;$1\007";;
		screen)
			echo -ne "\033_$1\033\\"
	esac
}


# If they're using screen or an xterm, set the title with each prompt
PROMPT_COMMAND="
	[ \`declare -F setdircolor\` ]  && setdircolor
	[ \`declare -F setloadcolor\` ] && setloadcolor
	[ \`declare -F settitle\` ]     && settitle \"${USER}@${BASE_HOSTNAME}:\${PWD2}\""
PS1="\[${COLOR_CLEAR}${UCOL}\]\u\[\${LCOL}\]@\[${HCOL}\]${BASE_HOSTNAME}\[${COLOR_CLEAR}\]\[\${SCOL}\]:\[\${DCOL}\]\$PWD2\[$COLOR_CLEAR\${SCOL}\] \\$ \[$COLOR_CLEAR\]"
#PS1="\[${UCOL}\]\u\[\${LCOL}\]@\[${HCOL}\]\h\[\${SCOL}\]:\[\${DCOL}\]\$PWD2\[$COLOR_CLEAR\${SCOL}\] \\$ \[$COLOR_CLEAR\]"
PS2='\[${COLOR_CLEAR}${SCOL}\]> \[$COLOR_CLEAR\]'
PS4='+ '

export PATH CDPATH INPUTRC EDITOR VISUAL PAGER SHELL PS1 PS2 PS4 PROMPT_COMMAND PYTHONSTARTUP HOSTNAME LANG LC_ALL

if   [ -f ~/.dir_colors ]; then
	eval `dircolors -b ~/.dir_colors`
elif [ -f /etc/DIR_COLORS ]; then
	eval `dircolors -b /etc/DIR_COLORS`
fi

# Determine vim version and set appropriate aliases to compensate
# assume an ancient broken version if it can't be determined
VIMVERSION=`vim --version 2>&1|head -n 1|cut -d " " -f 5`
if [ -n "${VIMVERSION##[0-9].*}" ] && [ -n "${VIMVERSION##[0-9][0-9].*}" ]; then
	VIMVERSION=0.0
fi
if [ ${VIMVERSION%%.*} -ge 6 ]; then
	alias vi="vim -o -X"
	alias vim="vim -o -X"
	alias vimdiff="vimdiff -X"
elif [ ${VIMVERSION%%.*} -ge 5 ]; then
	alias vi="vim -o"
	alias vim="vim -o"
else
	alias vim="vi"
fi

# Aliases
alias less='less -X -R'
alias d="ls -F --color=always"
alias ll="ls -Fl --color=always"
alias dir="ls -Flh --color=always"
alias dirh="ls -Flha --color=always"
alias emacs='emacs -nw'
alias cls='clear'
alias x='exit'
alias rd='rmdir'
alias md='mkdir'
alias h='history'
alias mo='more'
alias le='less'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
function mcd {
	mkdir "$@"; cd "$@"
}
function rcd {
	cd `readlink "$@"`
}
alias bc='bc -l'
alias dush='du -sh'
alias dus='du -s'
alias duh='du -h'
alias dfh='df -h'
alias chall='chmod -R a+rX'
alias hack='settitle Nethack!; PAGER="less" ibmfilter /usr/games/nethack'
alias nethack='settitle "Nethack on nethack.alt.org"; TERM="xterm-color" ibmfilter telnet nethack.alt.org'
alias mysql='mysql -p'
alias sudo='sudo '
alias aticonfig='aticonfig -i /etc/X11/xorg.conf'

# CVS aliases
alias cvs-st='cvs status 2>&1 | egrep "(^\? |Status: )" | grep -v Up-to-date'

export CVSROOT=:pserver:tschumm:Uj48crRp@cvs.digital-chalk.net:2401/var/cvs/externaldevelopers

# This line was appended by KDE
# Make sure our customised gtkrc file is loaded.
export GTK2_RC_FILES="$HOME/.gtkrc-2.0:$HOME/.kde/share/config/gtkrc-2.0:/etc/gtk-2.0/gtkrc"
