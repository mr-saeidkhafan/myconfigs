call plug#begin()
" auto complete and document
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'davidhalter/jedi-vim'

Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf'
Plug 'mbbill/undotree'
Plug 'morhetz/gruvbox'

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


filetype plugin on

" auto complition
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#enable_typeinfo = 0
let g:deoplete#disable_auto_complete = 1
let g:jedi#popup_select_first = 0
let g:jedi#smart_auto_mappings = 0
set completeopt=menu,noinsert

call deoplete#custom#option({'auto_complete_delay' : 0, 'auto_refresh_delay': 0, 'ignore_case': 1, })

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

" don't insert a newline when selecting with <Enter>
inoremap <expr> <CR> (pumvisible() ? "\<c-y>" : "\<CR>")

" jedi
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#show_call_signatures = 0

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

" formatting
map <F7> gg=G<C-o><C-o>

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
