#!/bin/bash
# vim:sts=4:sw=4
# ============================================================================
# Author - Tom Schumm <phong@phong.org>
# Super fancy colors!
# ============================================================================

# TODO(fwiffo): Change with time of day!
COLOR_CLOCK=$F_0xb1

# My users are green, admin/root is red, other is gray/white
case $USER in # {{{
    phong)          COLOR_USER=$F_LGREEN;;
    fwiffo)         COLOR_USER=$F_0x23  ;;
    tom)            COLOR_USER=$F_DGREEN;;
    Tom)            COLOR_USER=$F_DGREEN;;
    tschumm)        COLOR_USER=$F_DGREEN;;
    root)           COLOR_USER=$F_0xa7  ;;
    Administrator)  COLOR_USER=$F_DRED  ;;
    admin)          COLOR_USER=$F_DRED  ;;
    *)              COLOR_USER=$F_DWHITE;;
esac # }}}

# TODO(fwiffo): Make these awesomer
function get_dir_color() { # {{{
    # Colorize the path portion of the prompt
    local DCOL=""

    # Background colors for major trees
    case $1 in
        /usr/local*)  DCOL="$B_LBLACK"  ;;
        /usr*)        DCOL="$B_DBLUE"   ;;
        /var*)        DCOL="$B_DYELLOW" ;;
        /opt*)        DCOL="$B_DMAGENTA";;
        /proc*|/dev*) DCOL="$B_DRED"    ;;
        *)            DCOL=""           ;;
    esac

    # Foreground colors for more specific
    case $1 in
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
                DCOL="$F_0x6e"          ;;
        /home*) DCOL="$F_0x6e$DCOL"     ;;
        /Users*)DCOL="$F_LCYAN$DCOL"    ;;
        /root*) DCOL="$F_DYELLOW$DCOL"  ;;
        /etc*)  DCOL="$F_DGREEN$DCOL"   ;;
        /dev*)  DCOL="$F_LYELLOW$DCOL"  ;;
        /proc*) DCOL="$F_LWHITE$DCOL"   ;;
        /mnt*)  DCOL="$F_DCYAN$DCOL"    ;;
        /tmp*|/var/tmp*)
                DCOL="$F_LYELLOW$DCOL"  ;;
        #/usr*|/var*|/opt*)
        *)      DCOL="$F_LWHITE$DCOL"   ;;
    esac

    echo $DCOL
} # }}}

function get_load_color() { # {{{

    if [[ $1 == "" ]]; then
        echo $COLOR_CLEAR
        return
    fi

    if   [[ $1 -lt  20 ]]; then echo $F_0x13
    elif [[ $1 -lt  40 ]]; then echo $F_0x14
    elif [[ $1 -lt  60 ]]; then echo $F_0x15
    elif [[ $1 -lt  80 ]]; then echo $F_0x1b
    elif [[ $1 -lt 100 ]]; then echo $F_0x21
    elif [[ $1 -lt 120 ]]; then echo $F_0x27
    elif [[ $1 -lt 140 ]]; then echo $F_0x2d
    elif [[ $1 -lt 160 ]]; then echo $F_0x33
    elif [[ $1 -lt 180 ]]; then echo $F_0x57
    elif [[ $1 -lt 200 ]]; then echo $F_0x7b
    elif [[ $1 -lt 240 ]]; then echo $F_0x9f
    elif [[ $1 -lt 280 ]]; then echo $F_0xc3
    elif [[ $1 -lt 320 ]]; then echo $F_0xe7
    elif [[ $1 -lt 360 ]]; then echo $F_0xe6
    elif [[ $1 -lt 400 ]]; then echo $F_0xe5
    elif [[ $1 -lt 460 ]]; then echo $F_0xe4
    elif [[ $1 -lt 520 ]]; then echo $F_0xe3
    elif [[ $1 -lt 580 ]]; then echo $F_0xe2
    elif [[ $1 -lt 640 ]]; then echo $F_0xdc
    elif [[ $1 -lt 720 ]]; then echo $F_0xd6
    elif [[ $1 -lt 800 ]]; then echo $F_0xd0
    elif [[ $1 -lt 900 ]]; then echo $F_0xca
    elif [[ $1 -lt 999 ]]; then echo $F_0xa0
    else                        echo $F_0x7c
    fi
} # }}}

