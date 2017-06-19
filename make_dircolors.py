#!/usr/bin/python

# == Term Section ================================================== # {{{
TERM Eterm
TERM ansi
TERM color-xterm
TERM con132x25
TERM con132x30
TERM con132x43
TERM con132x60
TERM con80x25
TERM con80x28
TERM con80x30
TERM con80x43
TERM con80x50
TERM con80x60
TERM cons25
TERM console
TERM cygwin
TERM dtterm
TERM eterm-color
TERM fbterm
TERM gnome
TERM gnome-256color
TERM jfbterm
TERM konsole
TERM konsole-256color
TERM kterm
TERM linux
TERM linux-c
TERM mach-color
TERM mlterm
TERM putty
TERM putty-256color
TERM rxvt
TERM rxvt-256color
TERM rxvt-cygwin
TERM rxvt-cygwin-native
TERM rxvt-unicode
TERM rxvt-unicode256
TERM rxvt-unicode-256color
TERM screen
TERM screen-256color
TERM screen-256color-bce
TERM screen-256color-s
TERM screen-256color-bce-s
TERM screen-bce
TERM screen-w
TERM screen.linux
TERM st
TERM st-256color
TERM vt100
TERM xterm
TERM xterm-16color
TERM xterm-256color
TERM xterm-88color
TERM xterm-color
TERM xterm-debian
TERM xterm-termite
# ================================================================== # }}}

# == Ordinary types of files ======================================= # {{{
NORMAL                  # Non-filename text
FILE                    # Regular file
RESET                   # Reset to "normal" color
DIR                     # Directory
LINK                    # Symbolic link (can be set to target instead of code)
MULTIHARDLINK           # Regular file with more than one hard link
ORPHAN                  # Symlink to nonexistent file, or non-stat'able file
MISSING                 # The non-existant file pointed to by ORPHAN
# ================================================================== # }}}

# == Fake files ==================================================== # {{{
FIFO                    # Named pipe
SOCK                    # Socket
DOOR                    # Door (weird IPC thing)
BLK                     # Block device driver
CHR                     # Character device driver
# ================================================================== # }}}

# == Files with special permissions ================================ # {{{
SETUID                  # File that is setuid (u+s)
SETGID                  # File that is setgid (g+s)
CAPABILITY              # File with capability
STICKY_OTHER_WRITABLE   # Dir that is sticky and other-writable (+t,o+w)
OTHER_WRITABLE          # Dir that is other-writable (o+w) and not sticky
STICKY                  # Dir with the sticky bit set (+t) and not other-writable
EXEC                    # Files with execute permissions
# ================================================================== # }}}

# == Archives ====================================================== # {{{
.7z
.ace
.arj
.bz2
.cpi
.gz
.iso
.rar
.tar
.tgz
.tbz2
.z
.Z
.zoo
# ================================================================== # }}}

# == Distribution packages ========================================= # {{{
.deb
.rpm
.apk
# ================================================================== # }}}

# == Raster images ================================================= # {{{
.bmp
.gif
.ico
.jpg
.JPG
.jpeg
.mng
.pbm
.pcx
.pgm
.png
.ppm
.tga
.tif
.tiff
.xbm
.xpm
.yuv
# ================================================================== # }}}

# == Vector images ================================================= # {{{
.ai
.emf
.svg
.svgz
.wmf
# ================================================================== # }}}

# == Photoshop files =============================================== # {{{
.xcf
.psd
# ================================================================== # }}}

# == RAW photos files ============================================== # {{{
.3fr
.ari
.arw
.bay
.crw
.cr2
.CR2
.cap
.dcs
.dcr
.dng
.drf
.eip
.erf
.fff
.iiq
.k25
.kdc
.mdc
.mef
.mos
.mrw
.nef
.nrw
.obm
.orf
.pef
.ptx
.pxn
.r3d
.raf
.raw
.rwl
.rw2
.rwz
.sr2
.srf
.srw
.x3f
# ================================================================== # }}}

# == Documents ===================================================== # {{{
.doc
.docx
.eps
.pdf
.ps
.rdf
.tex
.txt
*Makefile
*README
*README.txt
*readme.txt
.md
.markdown
*README.markdown
.csv
# ================================================================== # }}}

# == Web documents ================================================= # {{{
.css
.html
.shtml
.xhtml
.xml
# ================================================================== # }}}

# == Configuration files =========================================== # {{{
.ini
.yml
.cfg
.conf
# ================================================================== # }}}

# == Source code =================================================== # {{{
*Makefile
*makefile
*configure
.c
.cpp
.cc
.h
.py
.sh
.go
.spt
.rb
.lua
.java
.js
.sql
# ================================================================== # }}}

# == Garbage ======================================================= # {{{
.log
.bak
*~
*#
.part
.incomplete
.swp
.tmp
.temp
.o
.pyc
.class
.cache
# ================================================================== # }}}

# == Audio formats ================================================= # {{{
.aac
.au
.flac
.mid
.midi
.mka
.mp3
.mpc
.ogg
.ra
.wav
.m4a
.axa
.oga
.spx
.xspf
# ================================================================== # }}}

# == Video formats ================================================= # {{{
.mov
.mpg
.mpeg
.m2v
.mkv
.ogm
.mp4
.m4v
.mp4v
.vob
.qt
.nuv
.wmv
.asf
.rm
.rmvb
.flc
.avi
.fli
.flv
.gl
.m2ts
.divx
.webm
.axv
.anx
.ogv
.ogx
.vob
.qt
# ================================================================== # }}}

# == Google Specific =============================================== # {{{

# Archives
.mpm
.jar
.par
.sar
.gar

# Special files
*BUILD
*OWNERS

# Source code
.szl
.proto
# ================================================================== # }}}

