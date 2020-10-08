call plug#begin('~/.vim/plugged')

Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf'
Plug 'alvan/vim-closetag'
Plug 'mbbill/undotree'
Plug 'morhetz/gruvbox'
Plug 'davidhalter/jedi-vim'
Plug 'deoplete-plugins/deoplete-jedi'
if has('nvim')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif

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
map <F9> :call system('thunar')<CR>

" formatting
map <F7> gg=G<C-o><C-o>

" changing the super key in insert mode
imap jj <Esc>

" auto complition
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#enable_typeinfo = 0
let g:deoplete#disable_auto_complete = 1
" use <tab> / <s-tab> to cycle through completions
function! s:check_back_space() abort "{{{
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ deoplete#manual_complete()

inoremap <silent><expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" automatically select the first match
set completeopt+=noinsert

" don't insert a newline when selecting with <Enter>
inoremap <expr> <CR> (pumvisible() ? "\<c-y>" : "\<CR>")

" matchers
" head   - exact matches
" length - don't show typed word
call deoplete#custom#source('_', 'matchers', ['matcher_head', 'terminal', 'matcher_length'])

" sort results alphabetically
call deoplete#custom#source('_', 'sorters', ['sorter_word'])

" jedi
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"

" style stuffs
syntax enable
syntax on
colorscheme gruvbox
set background=dark

" setters
set hlsearch
set incsearch
set smartcase
set ignorecase
set ts=4 sw=4
set splitbelow
set splitright
set noswapfile
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
