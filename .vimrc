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
" pylint
map <F6> :!pylint %<CR>
" run python
map <F8> :w \| term python %<CR>
" for opening my file manager
map <F9> :!thunar $(dirname %) &<CR>
" delete buffer
map <c-c><c-c> :bd!<CR>
" map copy past everywhere!
vnoremap <C-S-c> "+y
map <C-S-v> "+p

" style stuffs
syntax on
colorscheme desert
set background=dark

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
set smarttab
set expandtab
set autoindent
set smartindent
set splitbelow
set splitright
set noswapfile
set laststatus=2
set statusline=%F%m%r%h%w%=\ %Y\ [%04l,%04v]\ %p%%\ %L
set scrolloff=7
set fileformat=unix
set guifont=Hack
set backspace=indent,eol,start

" custom colors
hi Visual ctermfg=white guifg=black guibg=white ctermbg=black
hi Pmenu ctermfg=lightgray guifg=lightgrey guibg=black  ctermbg=black
hi PmenuSel ctermfg=black ctermbg=white cterm=bold,reverse
hi StatusLine ctermfg=white guifg=white ctermbg=black guibg=black gui=bold,reverse
hi Normal guibg=black
hi NonText guibg=black
hi Search guifg=black ctermfg=white guibg=white ctermbg=black gui=bold cterm=bold,reverse
hi Cursor guibg=NONE guifg=NONE gui=reverse

" gui stuffs
set guioptions -=m
set guioptions -=T
set guioptions +=a
set guitablabel=%N-\%t\ %M
