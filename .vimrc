call plug#begin('~/.vim/plugged')
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'bling/vim-bufferline'
Plug 'ntpeters/vim-better-whitespace'
call plug#end()

" highlight whitespaces
let g:better_whitespace_enabled=1

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

" fzf
let g:fzf_preview_window = 'right:60%'
nnoremap <C-p> :FZF --preview=head\ -50\ {}<Cr>

" SHORTCUTS
" pylint
map <F6> :!pylint %<CR>

" run python
map <F8> :w \| term python %<CR>

" for opening my file explorer
map <F9> :!thunar $(dirname %) &<CR>

" map copy past everywhere!
vnoremap <C-c> "+y

" next and previous buffers
map <C-PageUp> :bp<CR>
map <C-PageDown> :bn<CR>

" no highlight
map <C-n> :noh<CR>

" cursor custom style
if &term =~? "xterm" || &term =~? "rxvt"
	let &t_SI = "\<Esc>[6 q"
	let &t_EI = "\<Esc>[1 q"
	autocmd VimLeave * let &t_me = "\<Esc>[1 q"
endif

" delete buffer
map <c-c><c-c> :bd!<CR>

" fix wraping
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" setters
set number
set hidden
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
set noswapfile
set nobackup
set laststatus=2
set statusline=%F%m%r%h%w%=\ %Y\ [%04l,%04v]\ %p%%\ %L
set scrolloff=8
set fileformat=unix
set backspace=indent,eol,start
set arabicshape!

" custom colors
set termguicolors
set background=dark

hi Visual ctermfg=black guifg=black guibg=white ctermbg=white
hi Pmenu ctermfg=lightgray guifg=lightgrey guibg=black  ctermbg=black
hi PmenuSel guifg=white guibg=black cterm=bold,reverse
hi Normal guibg=black ctermfg=white guifg=white
hi NonText guibg=black
hi Search guifg=white ctermfg=white guibg=black ctermbg=black gui=bold cterm=bold,reverse
hi Cursor guibg=NONE guifg=NONE gui=reverse
" gui stuffs
set guioptions-=m
set guioptions-=T
set guioptions+=a
set laststatus=0
