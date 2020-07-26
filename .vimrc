call plug#begin('~/.vim/plugged')

Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf'
Plug 'alvan/vim-closetag'
Plug 'mbbill/undotree'
Plug 'morhetz/gruvbox'

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
syntax enable
syntax on
colorscheme gruvbox
set background=dark

" setters
set smartcase
set hlsearch
set incsearch
set ts=4 sw=4
set splitbelow
set splitright
set noswapfile
set clipboard=unnamedplus
set laststatus=2
set statusline=%F%m%r%h%w%=\ %Y\ [%04l,%04v]\ %p%%\ %L\ 
set visualbell

" cursor custom style
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" custom colors
hi Comment ctermfg=red
hi Number ctermfg=red
hi Normal ctermfg=white ctermbg=black
hi String ctermfg=173
hi Function ctermfg=red
hi Number ctermfg=red
hi Visual ctermfg=white ctermbg=black
