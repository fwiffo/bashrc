#!/bin/bash
# vim:sts=4:sw=4
# ============================================================================
# Author - Tom Schumm <phong@phong.org>
# A few handy utility functions used for my bash environment
# ============================================================================

function ellipsis_path() { # {{{
    if [ "$1" == "" ] || [ "$2" == "" ]; then
        echo /
        return
    elif [ ${#1} -le $2 ]; then
        echo "$1"
        return
    fi

    local ELIP_PATH="${1#/}"
    while [ ${#ELIP_PATH} -gt `expr $2 - 2` ] && [ "${ELIP_PATH}" != "${1##/*/}" ]; do
        ELIP_PATH="${ELIP_PATH#*/}"
    done

    echo …/"$ELIP_PATH"
} # }}}

function set_title() { # {{{
    WINDOW_TITLE="$1"
    case $TERM in
        xterm*|konsole*|rxvt*|eterm*|cygwin*)
            echo -ne "\033]0;$1\007";;
        screen)
            echo -ne "\033_$1\033\\"
    esac
} # }}}

function get_loadavg() { # {{{
    if [[ -f /proc/loadavg ]]; then
        local LOAD=`cut -f 1 -d ' ' /proc/loadavg`
        LOAD=${LOAD%.*}${LOAD#*.}
        LOAD=${LOAD#0}
        LOAD=${LOAD#0}
        echo $LOAD
        return
    fi
} # }}}
