#!/bin/bash
# ~/.profile
# vim:ts=4:sw=4:noet:
# Handles user specific variables, etc. that should be set regardless of
# shell, xsession or whatever.
# (C) 2005 Thomas Schumm (visit http://www.phong.org)

USER=`whoami`

# Get used to this default umask
umask 077

# add more things to path
if [ $USER != 'root' ]; then
	ADDLIST="/sbin /usr/sbin /usr/local/sbin /usr/local/bin $HOME/local/bin /opt/bin
		/usr/games/bin /usr/local/games/bin /usr/local/bin/scripts"
else
	ADDLIST="/sbin /usr/sbin /usr/local/sbin /usr/local/bin /usr/local/bin/scripts
		/root/local/bin /opt/bin"
fi
for ADDPATH in $ADDLIST; do
	if [ -d $ADDPATH ] && [ "$PATH" = "${PATH#*$ADDPATH}" ]; then
		PATH=$ADDPATH:$PATH
	fi
done
unset ADDPATH
unset ADDLIST

# use a TTL for SSH_AGENT (used by the xsesson when calling ssh-agent)
#SSH_AGENT_TTL=3600
#export SSH_AGENT_TTL
