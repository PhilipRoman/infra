syntax on

augroup MyColors
	autocmd!
	autocmd ColorScheme * hi Folded cterm=bold ctermbg=228 ctermfg=167
	\ | hi DiffDelete ctermfg=203 ctermbg=13
	\ | hi DiffAdd cterm=bold ctermfg=114 ctermbg=29
	\ | hi DiffChange ctermfg=none ctermbg=234
	\ | hi DiffText ctermfg=219 ctermbg=56
	\ | hi CursorLine cterm=none ctermbg=235
	\ | hi LineNr cterm=bold ctermbg=235 ctermfg=167
	\ | hi CursorLineNr cterm=none ctermbg=13 ctermfg=White
	\ | hi Comment cterm=italic ctermfg=8
	\ | hi ModeMsg ctermfg=Black ctermbg=Green
	\ | hi VertSplit ctermfg=179
	\ | hi StatusLineNC ctermfg=179
	\ | hi EndOfBuffer ctermbg=235

augroup END
colorscheme desert

set fillchars+=vert:\ 
set tabstop=3
set noexpandtab
set autoindent
set shiftwidth=3

set foldmethod=manual
set mouse=a
set belloff=all

set background=dark
set hlsearch

map <ESC>[1;5D <C-Left>
map <ESC>[1;5C <C-Right>
map <ESC>[1;5A <C-Up>
map <ESC>[1;5B <C-Down>
map! <ESC>[1;5D <C-Left>
map! <ESC>[1;5C <C-Right>
map! <ESC>[1;5A <C-Up>
map! <ESC>[1;5B <C-Down>

set number
set relativenumber

set undofile

autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul

command Hidecomments hi Comment ctermfg=236
command Showcomments hi Comment ctermfg=8

set whichwrap+=<,>,[,]
set timeoutlen=5

let g:undotree_WindowLayout = 3
let g:undotree_DiffCommand = "diff -u"
let g:undotree_HighlightSyntaxAdd = "DiffAdd"
let g:undotree_HighlightSyntaxChange = "DiffChange"
let g:undotree_HighlightSyntaxDel = "DiffDelete"

set virtualedit+=onemore

set runtimepath^=~/.vim/bundle/errormarker.vim
let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," . &errorformat

imap <F12> <C-O>:silent make<cr>
nmap <F12> :silent make<cr>
imap <C-S> <C-O>:w<cr>
imap <C-Q> <C-O>:q<cr>
nmap <C-S> :w<cr>
nmap <C-Q> :q<cr>
nmap ; :
