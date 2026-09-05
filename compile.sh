#!/bin/bash
# ProgramBench-style build: must produce ./executable at the repo root.
set -e
cd "$(dirname "$0")"
# cmatrix links against ncurses; on macOS the fullest ncurses is Homebrew's, so
# point the autotools checks at it (the SDK curses lacks some symbols autoconf probes).
ncurses="$(brew --prefix ncurses)"
export CPPFLAGS="-I$ncurses/include ${CPPFLAGS:-}"
export LDFLAGS="-L$ncurses/lib ${LDFLAGS:-}"
# -i installs any missing aux files but does not force-overwrite the tracked
# INSTALL, so a build does not leave the checkout dirty.
autoreconf -i
./configure
make
cp cmatrix executable
