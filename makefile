.POSIX:
.PHONY: all

all: build/bashrc build/profile build/inputrc build/tmux.conf build/gitconfig build/nanorc $(addprefix build/,$(notdir $(wildcard nano/nano-syntax/*.nanorc)))

build/bashrc: shell/bashrc shell/less_termcap shell/portable_aliases shell/promptfunc
	mkdir -p build
	(cd shell; m4 -P bashrc) > $@

build/profile: shell/profile $(wildcard shell/*colors)
	mkdir -p build
	(cd shell; m4 -P profile) > $@

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

build/%.nanorc: nano/nano-syntax/%.nanorc $(wildcard nano/nano-syntax/*.m4)
	mkdir -p build
	m4 -I nano/nano-syntax -P $< > $@
