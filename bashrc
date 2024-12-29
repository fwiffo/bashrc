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
USERHOST="$USER@$HOSTNAME"

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
LS_COLORS='no=00:fi=00:rs=0:di=0;38;5;2:ln=01;38;5;111:mh=00:pi=48;5;230;38;5;136;01:so=48;5;230;38;5;136;01:bd=;4;230;38;5;142;01:cd=;1;230;38;5;94;01:or=38;5;009;48;5;052:su=48;5;160;38;5;230:sg=48;5;136;38;5;230:ca=30;41:st=48;5;33;38;5;230:ow=38;5;110:tw=48;5;64;38;5;230:ex=0;38;5;154:*.s=01;38;5;123:*.c=01;38;5;148:*.h=01;38;5;150:*.cpp=01;38;5;064:*.go=01;38;5;081:*_test.go=01;38;5;025:*.rb=00;38;5;160:*.ru=01;38;5;088:*.lua=01;38;5;025:*.js=01;38;5;003:*.sh=01;38;5;067:*Makefile=0;38;5;243:*Rakefile=0;38;5;124:*Gemfile=0;38;5;3:*Gemfile.lock=0;38;5;239:*.gemspec=0;38;5;3:*Procfile=0;38;5;244:*Gopkg.toml=0;38;5;3:*Gopkg.lock=0;38;5;239:*.gitignore=0;38;5;243:*.gitattributes=0;38;5;243:*.erb=01;38;5;012:*.html=01;38;5;012:*.slim=01;38;5;012:*.haml=01;38;5;012:*.sass=01;38;5;012:*.scss=01;38;5;012:*.json=01;38;5;3:*.ndjson=01;38;5;3:*.ldjson=01;38;5;3:*.yml=01;38;5;3:*.yaml=01;38;5;3:*.xml=01;38;5;3:*.csv=01;38;5;3:*.pb=01;38;5;201:*.proto=01;38;5;201:*.bson=01;38;5;201:*.txt=01;38;5;15:*.tex=01;38;5;15:*.nfo=01;38;5;5:*.rdf=01;38;5;5:*.docx=01;38;5;5:*.pdf=01;38;5;5:*.markdown=01;38;5;5:*.md=01;38;5;5:*README=01;38;5;200:*README.md=01;38;5;200:*README.txt=01;38;5;200:*readme.txt=01;38;5;200:*LICENSE=01;38;5;165:*LICENSE.txt=01;38;5;165:*AUTHORS=01;38;5;165:*COPYRIGHT=01;38;5;165:*CONTRIBUTORS=01;38;5;165:*CONTRIBUTING.md=01;38;5;165:*PATENTS=01;38;5;165:*.torrent=00;38;5;120:*rc=01;38;5;141:*.cfg=01;38;5;005:*.conf=01;38;5;005:*.log=00;38;5;239:*.bak=00;38;5;239:*.aux=00;38;5;239:*.out=00;38;5;239:*.toc=00;38;5;239:*~=00;38;5;239:*#=00;38;5;239:*.part=00;38;5;239:*.incomplete=00;38;5;239:*.swp=00;38;5;239:*.tmp=00;38;5;239:*.temp=00;38;5;239:*.o=00;38;5;239:*.pyc=00;38;5;239:*.class=00;38;5;239:*.cache=00;38;5;239:*.rdb=00;38;5;239:*.aac=00;38;5;166:*.au=00;38;5;166:*.flac=00;38;5;166:*.mid=00;38;5;166:*.midi=00;38;5;166:*.mka=00;38;5;166:*.mp3=00;38;5;166:*.ogg=00;38;5;166:*.wav=00;38;5;166:*.m4a=00;38;5;166:*.mov=01;38;5;202:*.mpg=01;38;5;202:*.mpeg=01;38;5;202:*.m2v=01;38;5;202:*.mkv=01;38;5;202:*.ogm=01;38;5;202:*.mp4=01;38;5;202:*.m4v=01;38;5;202:*.mp4v=01;38;5;202:*.vob=01;38;5;202:*.qt=01;38;5;202:*.nuv=01;38;5;202:*.wmv=01;38;5;202:*.asf=01;38;5;202:*.rm=01;38;5;202:*.rmvb=01;38;5;202:*.flc=01;38;5;202:*.avi=01;38;5;202:*.fli=01;38;5;202:*.flv=01;38;5;202:*.gl=01;38;5;202:*.m2ts=01;38;5;202:*.divx=01;38;5;202:*.webm=01;38;5;202:*.jpg=00;38;5;215:*.JPG=00;38;5;215:*.jpeg=00;38;5;215:*.gif=00;38;5;215:*.bmp=00;38;5;215:*.pbm=00;38;5;215:*.pgm=00;38;5;215:*.ppm=00;38;5;215:*.tga=00;38;5;215:*.xbm=00;38;5;215:*.xpm=00;38;5;215:*.tif=00;38;5;215:*.tiff=00;38;5;215:*.pxm=00;38;5;215:*.png=00;38;5;215:*.PNG=00;38;5;215:*.svg=00;38;5;215:*.svgz=00;38;5;215:*.mng=00;38;5;215:*.pcx=00;38;5;215:*.dl=00;38;5;215:*.xcf=00;38;5;215:*.xwd=00;38;5;215:*.yuv=00;38;5;215:*.cgm=00;38;5;215:*.emf=00;38;5;215:*.eps=00;38;5;215:*.CR2=00;38;5;215:*.ico=00;38;5;215:*.iso=01;38;5;209:*.dmg=01;38;5;209:*.zip=01;38;5;61:*.tar=00;38;5;61:*.tgz=01;38;5;61:*.lzh=01;38;5;61:*.z=01;38;5;61:*.Z=01;38;5;61:*.7z=01;38;5;61:*.gz=01;38;5;61:*.bz2=01;38;5;61:*.bz=01;38;5;61:*.deb=01;38;5;61:*.rpm=01;38;5;61:*.jar=01;38;5;61:*.rar=01;38;5;61:*.apk=01;38;5;61:*.gem=01;38;5;61:';
export LS_COLORS

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
PS1_line0="${XL}\${PROMPT_BAR} ${XU}\u${XL}@${XH}${HOSTNAME}${XL} ◄── ${XT}\d, \t${XC}${XL} ◄─╯"
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
alias python='python3'
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

