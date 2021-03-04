.POSIX:
.PHONY: all install

all: build/bashrc build/inputrc build/tmux.conf build/gitconfig build/nanorc $(addprefix build/,$(notdir $(wildcard nano/nano-syntax/*.nanorc)))

install:
	sh install.sh

build/bashrc: shell/bashrc shell/less_termcap shell/portable_aliases shell/promptfunc
	mkdir -p build
	(cd shell; m4 -P bashrc) > $@

build/inputrc: shell/inputrc
	mkdir -p build
	m4 -I shell -P $< > $@

build/tmux.conf: tmux/tmux.conf
	mkdir -p build
	m4 -I tmux -P $< > $@

build/gitconfig: git/gitconfig
	mkdir -p build
	m4 -I git -P $< > $@

build/nanorc: nano/nanorc
	mkdir -p build
	(cd nano; m4 -P nanorc) > $@

build/%.nanorc: nano/nano-syntax/%.nanorc
	mkdir -p build
	m4 -I nano/nano-syntax -P $< > $@
