syntax on

colorscheme desert

function! FixColorscheme() "{{{
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
	hi! TabLineFill ctermfg=0
	hi! String ctermfg=2 ctermbg=235
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
	hi! SpecialKey ctermfg=235 cterm=italic
	hi! ExtraWhitespace ctermbg=17
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

set foldmethod=manual
set mouse=a
set belloff=all

set background=dark
set hlsearch
set ttyfast

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
set updatetime=60000

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
set tabpagemax=50

let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," . &errorformat

function! SaveAndMake()
	:w
	:silent make
endfunction

inoremap <F12> <C-O>:call SaveAndMake()<cr>
nnoremap <F12> :call SaveAndMake()<cr>
inoremap <C-S> <C-O>:w<cr>
inoremap <C-Q> <C-O>:q<cr>
nnoremap <C-S> :w<cr>
nnoremap <C-Q> :q<cr>
nnoremap ; :

vnoremap <C-E> :!
nnoremap <C-E> :%!
inoremap <C-E> <C-O>:%!

nnoremap <C-A> aW

inoremap <C-J> <C-O>:Buffers<CR>
nnoremap <C-J> :Buffers<CR>
vnoremap <C-J> :Buffers<CR>

cnoremap <C-L> Buffers<CR>
cnoremap <C-W> Windows<CR>
cnoremap <C-F> Files<CR>

au FocusLost * silent! wa

au FocusLost   * set norelativenumber
au FocusGained * set relativenumber

set hidden
