call plug#begin('~/.vim/plugged')
Plug 'mbbill/undotree'
call plug#end()
" changing the super key in insert mode
imap jj <Esc>

" undotree
nnoremap <F5> :UndotreeToggle<cr>

au BufReadPost * call ReadUndo()
au BufWritePost * call WriteUndo()
func ReadUndo()
	if filereadable('/tmp/daily/UNDO/' . expand('%:t'))
		rundo /tmp/daily/UNDO/%:t
	endif
endfunc
func WriteUndo()
	let dirname = '/tmp/daily/UNDO'
	if !isdirectory(dirname)
		call mkdir(dirname)
	endif
	wundo /tmp/daily/UNDO/%:t
endfunc

" SHORTCUTS
" run python
map <F8> :w \| term python %<CR>
" for opening my file manager
map <F9> :!thunar $(dirname %) &<CR>
" delete buffer
map <c-c><c-c> :bd!<CR>
" pylint
map <F6> :!pylint %<CR>

" style stuffs
syntax on
colorscheme desert
set background=dark

" highlight extra whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" cursor custom style
if &term =~? "xterm" || &term =~? "rxvt"
	let &t_SI = "\<Esc>[6 q"
	let &t_EI = "\<Esc>[1 q"
	autocmd VimLeave * let &t_me = "\<Esc>[1 q"
endif

" setters
set hlsearch
set incsearch
set smartcase
set ignorecase
set ts=4 sw=4
set shiftwidth=4
set splitbelow
set splitright
set noswapfile
set laststatus=2
set statusline=%F%m%r%h%w%=\ %Y\ [%04l,%04v]\ %p%%\ %L
set scrolloff=7
set fileformat=unix
set autoindent

" custom colors
hi Visual ctermfg=white ctermbg=black
hi Pmenu ctermfg=lightgray ctermbg=black
hi PmenuSel ctermfg=black ctermbg=white cterm=bold,reverse

" gui stuffs
set guioptions -=m
set guioptions -=T
set guioptions +=a
source $VIMRUNTIME/mswin.vim
behave mswin
