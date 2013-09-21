#!/bin/bash
# ~/.bash_logout
# vim:ts=4:sw=4:noet:
# (C) 2005 Thomas Schumm (visit http://www.phong.org)
# clear out sudo tickets and clear screen for security
[ -e /usr/bin/sudo ] && sudo -k
clear
