#!/bin/sh
while read url; do
	name="$(echo "$url" | sed -E 's/\.git$//; s:/+$::' | grep -Eo '[^/]+$')"
	printf '%s\n' "$name" >&2
	mkdir -p ~/.vim/pack/"$name"/start
	if [ -d ~/.vim/pack/"$name"/start/"$name" ]; then
		printf 'Already exists: %s\n' "$name" >&2
	else
		(cd ~/.vim/pack/"$name"/start && git clone --depth 1 "$url")
	fi
done <<EOM
https://github.com/jlanzarotta/bufexplorer
https://github.com/mh21/errormarker.vim
https://github.com/junegunn/fzf.vim
https://github.com/preservim/nerdtree.git
https://github.com/PhilRunninger/nerdtree-visual-selection
https://github.com/vim-syntastic/syntastic.git
https://github.com/preservim/tagbar/
https://github.com/wincent/terminus
https://github.com/mbbill/undotree.git
https://github.com/powerman/vim-plugin-viewdoc.git
https://github.com/mhinz/vim-signify
https://github.com/jpalardy/vim-slime
https://github.com/tpope/vim-surround
https://github.com/frazrepo/vim-rainbow
https://github.com/easymotion/vim-easymotion
https://github.com/tpope/vim-commentary
https://github.com/azabiong/vim-highlighter
https://github.com/michaeljsmith/vim-indent-object
EOM
