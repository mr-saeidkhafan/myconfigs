call plug#begin('~/.vim/plugged')
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'bling/vim-bufferline'
Plug 'ntpeters/vim-better-whitespace'
call plug#end()

" include search and path improvement for python. shortcut ([ + ctrl i) and ([ + shift i)
setlocal path=.,**
setlocal wildignore=*.pyc
set include=^\\s*(from\\\|import\\)\s*\\zs\\(\\S\\+\\s\\{-}\\)*\\ze\\($\\\|\as\\)
function! PyInclude(fname)
    let parts = split(a:frame, ' import ')
    let l = parts[0]
    if len(parts) > 1
        let r = parts[1]
        let joined = join([l, r], '.')
        let fp = substitute(joined, '\.', '/', 'g') . '.py'
        let found = glob(fp, 1)
        if len(found)
            return found
        endif
    endif
    return substitute(l, '\.', '/', 'g') . '.py'
endfunction
setlocal includeexpr=PyInclude(v:frame)
setlocal define=^\\s*\\<\\(def\\\|class\\)\\>

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

" pylint
map <F6> :!pylint %<CR>

" run python
map <F8> :w \| term python %<CR>

" for opening my file explorer
map <F9> :!thunar $(dirname %) &<CR>

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

" copy to clipboard
nnoremap <C-S-c> "+y
vnoremap <C-S-c> "+y

" setters
set number
set hidden
set hlsearch
set incsearch
set ts=4 sw=4 st=4
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
set splitbelow
set splitright
set timeoutlen=1000 ttimeoutlen=0

" custom colors
set termguicolors
set background=dark

hi Visual guifg=black guibg=white
hi Pmenu guifg=lightgrey guibg=black
hi PmenuSel guifg=white guibg=black cterm=bold,reverse
hi Normal guibg=black guifg=white
hi NonText guibg=black
hi Search guifg=black guibg=white
hi Cursor guibg=NONE guifg=NONE gui=reverse

" gui stuffs
set guioptions-=m
set guioptions-=T
set guioptions+=a
set laststatus=0
set guifont=Liberation\ Mono\ Regular\ 11
