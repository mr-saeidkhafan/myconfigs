call plug#begin()
" formatter
Plug 'tell-k/vim-autopep8'
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'mbbill/undotree'
Plug 'morhetz/gruvbox'
Plug 'jupyter-vim/jupyter-vim'

call plug#end()

" changing the super key in insert mode
imap jj <Esc>


" auto close tag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.py,*.js'
let g:closetag_filetypes = 'html,xhtml,phtml,py,js'
" non closing tag
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

let g:closetag_emptyTags_caseSensitive = 1

" jupyter vim
let g:python3_host_prog = '/usr/bin/python3.8'

" create undo files
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

" SHORTCUTS
" undotree
nnoremap <F5> :UndotreeToggle<cr>
" run python
map <F8> :w \| term python %<CR>
" for opening my file manager
map <F9> :call system('thunar')<CR>
" delete buffer
map <c-c><c-c> :bd!<CR>
" delete buffer
map <F6> :!pylint %<CR>

" formatting
autocmd FileType python noremap <buffer> <F7> :call Autopep8()<CR>
let g:autopep8_aggressive=2
let g:autopep8_disable_show_diff=1

" style stuffs
syntax enable
syntax on
colorscheme gruvbox
set background=dark

" setters
set hidden
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
set backspace=indent,eol,start
set fileformat=unix
set autoindent
set completeopt=menu,noinsert

" custom colors
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
highlight Comment ctermfg=grey cterm=italic
hi Function ctermfg=red
hi Normal ctermfg=white ctermbg=black
hi Number ctermfg=red
hi Float ctermfg=red
hi String ctermfg=white cterm=italic
hi Visual ctermfg=white ctermbg=black
hi StatusLine ctermfg=white ctermbg=black cterm=bold,reverse
hi NonText ctermfg=gray
hi Conditional ctermfg=red
hi PreProc ctermfg=red
hi pythonBoolean ctermfg=red
hi pythonFunction ctermfg=red
hi pythonImport ctermfg=red

hi Pmenu ctermfg=lightgray ctermbg=black
hi PmenuSel ctermfg=black ctermbg=white cterm=bold,reverse
