call plug#begin('~/.vim/plugged')

Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf'
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
syntax on
set laststatus=2
set statusline=%F%m%r%h%w%=\ %Y\ [%04l,%04v]\ %p%%\ %L\ 
set visualbell

" cursor custom style
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" custom colors
hi Comment ctermfg=46
hi Special ctermfg=red
hi Normal ctermfg=white
hi String ctermfg=173
hi Function ctermfg=white cterm=bold
"hi Special ctermfg=white cterm=bold
hi Visual ctermfg=black ctermbg=white
