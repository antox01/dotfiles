" Basic vim settings
let mapleader=" "

set nocompatible
"filetype plugin on

set number relativenumber
syntax on
set autoindent
set ignorecase
set smartcase
set smartindent
set incsearch
set hlsearch
set encoding=utf-8
set clipboard=unnamedplus

set path+=**
set wildmenu
set wildmode=longest,list

set completeopt=menuone,longest

" === TAB Settings === "
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" Plugin installation
call plug#begin('~/.local/share/nvim/plugged')
    " Autocompletion plugins
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Colorscheme
    "Plug 'tomasiser/vim-code-dark'
    Plug 'chriskempson/base16-vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Vim colorizer
    Plug 'norcalli/nvim-colorizer.lua'

    " Vim movements
    Plug 'unblevable/quick-scope'
    Plug 'justinmk/vim-sneak'
    Plug 'liuchengxu/vim-which-key'

    " FZF
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
call plug#end()

if has("termguicolors")     " set true colors
    set t_8f=\[[38;2;%lu;%lu;%lum
    set t_8b=\[[48;2;%lu;%lu;%lum
    set termguicolors
endif
"set termguicolors
colorscheme base16-default-dark

" Importing plugins settings
source ~/.config/nvim/plug-config/coc-config.vim " Coc autocomplete settings
source ~/.config/nvim/plug-config/netrw.vim
source ~/.config/nvim/plug-config/sneak.vim
source ~/.config/nvim/plug-config/fzf.vim
source ~/.config/nvim/plug-config/whick-key.vim
luafile ~/.config/nvim/lua/plug-colorizer.lua

" Cursor line
set cursorline
set cursorcolumn
"highlight CursorLine ctermbg=Yellow cterm=bold guibg=#2b2b2b
"highlight CursorColumn ctermbg=Yellow cterm=bold guibg=#2b2b2b

set noshowmode

set splitbelow splitright

" Mapping a better way to move between the splits in vim
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h

" QuickScope Highlighting
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline

" Vim-airline
let g:airline#extensions#wordcount#enable = 1
let g:airline#extensions#hunks#non_zero_only = 1
"let g:airline_theme = 'codedark'

" Remap ESC to jk
:imap jk <ESC>
" Remap ESC to jj
:imap jj <ESC>

