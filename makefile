.POSIX:
.PHONY: all

all: build/bashrc build/profile build/inputrc build/tmux.conf build/gitconfig build/nanorc build/vimrc

install:
	exit 1

install-user:
	exit 1

build/bashrc: shell/bashrc shell/less_termcap shell/portable_aliases
	mkdir -p build
	(cd shell; m4 -P bashrc) > $@

build/profile: shell/profile $(wildcard shell/*colors)
	mkdir -p build
	(cd shell; m4 -P profile) > $@

build/inputrc: shell/inputrc
	mkdir -p build
	m4 -I shell -P shell/inputrc > $@

build/tmux.conf: tmux/tmux.conf
	mkdir -p build
	m4 -I tmux -P tmux/tmux.conf > $@

build/gitconfig: git/gitconfig
	mkdir -p build
	m4 -I git -P git/gitconfig > $@

build/vimrc: vim/vimrc vim/cterm2gui.lua
	mkdir -p build
	"$$( { command -v lua; command -v lua5.4; command -v lua5.3; command -v lua5.2; command -v lua5.1; command -v luajit; } | sed 1q)" vim/cterm2gui.lua <vim/vimrc >$@

build/nanorc: nano/nanorc $(wildcard nano/nano-syntax/*.nanorc)
	mkdir -p build
	(echo $^ | xargs -n1 m4 -P -I nano/nano-syntax ) > $@
