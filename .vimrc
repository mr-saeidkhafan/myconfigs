call plug#begin('~/.vim/plugged')

Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf'
Plug 'morhetz/gruvbox'
Plug 'alvan/vim-closetag'
Plug 'mbbill/undotree'

call plug#end()

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

" explore config
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" fzf conf
let g:fzf_preview_window = 'right:60%'
nnoremap <C-p> :FZF --preview=head\ -50\ {}<Cr>

" shortcut for opening my file manager
map <F9> :call system('pcmanfm')<CR>

" formatting
map <F7> gg=G<C-o><C-o>

" changing the super key in insert mode
imap jj <Esc>

" style stuffs
colorscheme gruvbox
set background=dark

" setters
set visualbell
set smartcase
set hlsearch
set incsearch
set ts=4 sw=4
set splitbelow
set splitright
set noswapfile
set mouse=a
set clipboard=unnamedplus
syntax on
set laststatus=2
set statusline=%F%m%r%h%w%=\ %Y\ [%04l,%04v]\ %p%%\ %L\ 

" cursor custom style
if &term =~? "xterm" || &term =~? "rxvt"
	let &t_SI = "\<Esc>[6 q"
	let &t_EI = "\<Esc>[1 q"
	autocmd VimLeave * let &t_me = "\<Esc>[1 q"
endif

" gui configs
set guioptions-=T
set guioptions-=m
set guioptions=Ace
set guifont=Noto\ Sans\ Mono\ 10

" custom colors
hi Comment ctermfg=46 guifg=green
hi Special ctermfg=12
hi Normal ctermfg=white guifg=white ctermbg=NONE guibg=black
hi String ctermfg=white guifg=white
hi Function ctermfg=white cterm=bold guifg=white gui=bold
hi Special ctermfg=white cterm=bold guifg=white gui=bold
hi Visual ctermfg=white ctermbg=black guifg=white guibg=black
