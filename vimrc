set nocompatible
syntax on

colorscheme desert

function! FixColorscheme() "{{{
	hi! Normal ctermbg=none
	hi! Folded cterm=bold ctermbg=228 ctermfg=167
	hi! DiffDelete ctermfg=203 ctermbg=13
	hi! DiffAdd cterm=bold ctermfg=114 ctermbg=29
	hi! DiffChange ctermfg=none ctermbg=234
	hi! DiffText ctermfg=219 ctermbg=56
	hi! CursorLine cterm=none ctermbg=235
	hi! LineNr cterm=bold ctermbg=235 ctermfg=167
	hi! CursorLineNr cterm=none ctermbg=13 ctermfg=White
	hi! Comment cterm=italic ctermfg=8
	hi! ModeMsg ctermfg=Black ctermbg=Green
	hi! VertSplit ctermfg=179
	hi! StatusLineNC ctermfg=179
	hi! EndOfBuffer ctermbg=235
	hi! TabLine ctermbg=5 ctermfg=3 cterm=bold
	hi! TabLineSel ctermbg=3 ctermfg=5 cterm=bold
	hi! TabLineFill ctermbg=none
	hi! String ctermfg=2 ctermbg=235
	hi! cFormat ctermfg=36 ctermbg=237
	hi! SpecialChar ctermfg=142 ctermbg=236
	hi! PreProc ctermfg=15 cterm=bold
	hi! Type ctermfg=24
	hi! StorageClass ctermfg=63
	hi! Operator ctermfg=6
	hi! Number ctermfg=121
	hi! Boolean ctermfg=121
	hi! Repeat ctermfg=202 cterm=bold
	hi! Statement ctermfg=202 cterm=bold
	hi! Conditional ctermfg=202 cterm=bold
	hi! Constant ctermfg=121
	hi! javaScopeDecl ctermfg=135
	hi! StatusLine ctermbg=235 ctermfg=3 cterm=bold
	hi! StatusLineNC ctermbg=235 ctermfg=166
	hi! SpecialKey ctermfg=235 cterm=italic
	hi! ExtraWhitespace ctermbg=17
	hi! MatchParen ctermbg=magenta ctermfg=yellow
	hi! Visual ctermbg=none ctermfg=none cterm=reverse,italic
	hi! luaFunc ctermbg=none ctermfg=white cterm=bold
	hi! luaFunction ctermbg=none ctermfg=24
endfunction
"}}}

augroup MyColors
	au!
	au ColorScheme * call FixColorscheme()
augroup END

call FixColorscheme()

" Show trailing whitespace:
match ExtraWhitespace /\s\+$/

" Show trailing whitespace and spaces before a tab:
match ExtraWhitespace /\s\+$\| \+\ze\t/

" Show tabs that are not at the start of a line:
match ExtraWhitespace /[^\t]\zs\t\+/

match

set laststatus=2
set fillchars+=vert:\ 
set list
set listchars=tab:▸\ 
set tabstop=3
set noexpandtab
set autoindent
set shiftwidth=3

set foldmethod=marker
set mouse=a
set belloff=all
set switchbuf=newtab

set background=dark
" set hlsearch
set nohlsearch
set ttyfast

set number
set relativenumber

set undofile
set updatetime=60000

set cul

autocmd InsertEnter * hi LineNr ctermfg=green cterm=bold | hi CursorLineNr ctermbg=22 ctermfg=white cterm=none
autocmd InsertLeave * hi LineNr ctermfg=167 cterm=bold | hi CursorLineNr ctermbg=magenta ctermfg=white cterm=none

command Hidecomments hi Comment ctermfg=236
command Showcomments hi Comment ctermfg=8

set whichwrap+=<,>,[,]
set timeout timeoutlen=1000 ttimeoutlen=100

let g:undotree_WindowLayout = 3
let g:undotree_DiffCommand = "diff -u"
let g:undotree_HighlightSyntaxAdd = "DiffAdd"
let g:undotree_HighlightSyntaxChange = "DiffChange"
let g:undotree_HighlightSyntaxDel = "DiffDelete"

let g:syntastic_mode_map = {'mode': 'passive'}

let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
let g:slime_bracketed_paste = 1

let g:TerminusCursorShape = 0

set virtualedit+=onemore
set tabpagemax=50

let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," . &errorformat

function! SaveAndMake()
	:w
	:silent make
endfunction

let mapleader = "\<C-k>"

noremap! <ESC>[1;5D <C-Left>
noremap! <ESC>[1;5C <C-Right>
noremap! <ESC>[1;5A <C-Up>
noremap! <ESC>[1;5B <C-Down>
nnoremap <ESC>[1;5D <C-Left>
nnoremap <ESC>[1;5C <C-Right>
nnoremap <ESC>[1;5A <C-Up>
nnoremap <ESC>[1;5B <C-Down>

nnoremap <C-Up> {
nnoremap <C-Down> }
vnoremap <C-Up> {
vnoremap <C-Down> }
inoremap <C-Up> <C-O>{
inoremap <C-Down> <C-O>}

nnoremap <ESC>[1;3D <c-w>h
nnoremap <ESC>[1;3C <c-w>l
nnoremap <ESC>[1;3A <c-w>k
nnoremap <ESC>[1;3B <c-w>j

noremap! <ESC>[1;3D <c-o><c-w>h
noremap! <ESC>[1;3C <c-o><c-w>l
noremap! <ESC>[1;3A <c-o><c-w>k
noremap! <ESC>[1;3B <c-o><c-w>j

noremap <leader><leader> :
inoremap <leader><leader> <C-O>:
noremap <leader>1 :!
inoremap <leader>1 <C-O>:!

inoremap <leader>m <C-O>:call SaveAndMake()<cr>
nnoremap <leader>m :call SaveAndMake()<cr>
noremap! <C-S> <ESC>:w<cr>
noremap! <C-Q> <ESC>
nnoremap <C-S> :w<cr>
nnoremap <C-Q> :q<cr>

nnoremap ; :
nnoremap , ;

vnoremap <C-E> :!
nnoremap <C-E> :%!
inoremap <C-E> <C-O>:%!

nnoremap <leader>d daW

nnoremap <leader>b :Buffers<CR>
nnoremap <leader>w :Windows<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>c :Commands<CR>

noremap! <leader>b <C-O>:Buffers<CR>
noremap! <leader>w <C-O>:Windows<CR>
noremap! <leader>f <C-O>:Files<CR>
noremap! <leader>c <C-O>:Commands<CR>

vnoremap <leader>b <C-O>:Buffers<CR>
vnoremap <leader>w <C-O>:Windows<CR>
vnoremap <leader>f <C-O>:Files<CR>
vnoremap <leader>c <C-O>:Commands<CR>

nnoremap <leader>s :SlimeSend<CR>
inoremap <leader>s <C-O>:SlimeSend<CR>
vnoremap <leader>s :SlimeSend<CR>

au FocusLost * silent! wa

au FocusLost   * set norelativenumber
au FocusGained * set relativenumber

set hidden

" see :help xterm-bracketed-paste
if &t_BE == ''
	let &t_BE = "\e[?2004h"
	let &t_BD = "\e[?2004l"
	let &t_PS = "\e[200~"
	let &t_PE = "\e[201~"
endif
