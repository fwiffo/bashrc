#!/bin/bash
# vim:sts=4:sw=4
# ============================================================================
# Author - Tom Schumm <phong@phong.org>
# For 16 color terminals, which aren't yet extinct
# ============================================================================

COLOR_CLOCK=$F_DMAGENTA

# My users are green, admin/root is red, other is gray/white
case $USER in # {{{
    phong)          COLOR_USER=$F_LGREEN;;
    fwiffo)         COLOR_USER=$F_LGREEN;;
    tom)            COLOR_USER=$F_DGREEN;;
    Tom)            COLOR_USER=$F_DGREEN;;
    tschumm)        COLOR_USER=$F_DGREEN;;
    root)           COLOR_USER=$F_LRED  ;;
    Administrator)  COLOR_USER=$F_DRED  ;;
    admin)          COLOR_USER=$F_DRED  ;;
    *)              COLOR_USER=$F_DWHITE;;
esac # }}}

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

    if   [[ $1 -lt  20 ]]; then echo $F_DBLUE
    elif [[ $1 -lt  40 ]]; then echo $F_LBLUE
    elif [[ $1 -lt  60 ]]; then echo $F_DCYAN
    elif [[ $1 -lt 100 ]]; then echo $F_DGREEN
    elif [[ $1 -lt 140 ]]; then echo $F_LCYAN
    elif [[ $1 -lt 180 ]]; then echo $F_LGREEN
    elif [[ $1 -lt 220 ]]; then echo $F_LYELLOW
    elif [[ $1 -lt 280 ]]; then echo $F_DYELLOW
    elif [[ $1 -lt 340 ]]; then echo $F_DRED
    else                        echo $F_LRED
    fi
} # }}}

