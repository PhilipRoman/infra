#!/bin/sh

make all

PREFIX="${PREFIX:-/}"

if [ ! -w "$PREFIX/" ]; then
	printf "Can't access prefix directory: %s\n" "$PREFIX/" >&2
	exit 1
fi

if [ -z "$BINPREFIX" ]; then
	BINPREFIX="/usr/local"
fi

install -vm 644 build/bashrc  $PREFIX/etc/profile.d/infra.bash
install -vm 644 build/profile  $PREFIX/etc/profile.d/infra.sh
install -vm 644 build/inputrc $PREFIX/etc/inputrc
install -vm 644 build/nanorc  $PREFIX/etc/nanorc
install -vm 644 build/tmux.conf $PREFIX/etc/tmux.conf

mkdir  -pvm 755 $PREFIX/etc/nanorc.d/
install -vm 644 build/*.nanorc $PREFIX/etc/nanorc.d/
install -vm 644 build/gitconfig $PREFIX/etc/gitconfig
install -vm 644 git/gitignore $PREFIX/etc/gitignore

mkdir  -pvm 755 $BINPREFIX/bin/
install -vm 755 tmux/tsend $BINPREFIX/bin/
install -vm 755 tmux/tmux-popup-session $BINPREFIX/bin/
if [ -f "/usr/bin/fzf" ]; then
	install -vm 755 fzf/* $BINPREFIX/bin/
fi
install -vm 755 misc/* $BINPREFIX/bin/
install -vm 755 nano/syntaxlist $BINPREFIX/bin/
install -vm 644 htoprc $PREFIX/etc/htoprc

if [ -w /usr/share/source-highlight ]; then
	install -vm 644 source-highlight/* /usr/share/source-highlight
fi
