runtime! archlinux.vim

" Plug-in imports
call plug#begin('~/.vim/plugged')
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'tomasiser/vim-code-dark'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
call plug#end()

" Set the leader key for future mapping
let mapleader= " "

set nocompatible
filetype plugin on

set number relativenumber
syntax on
set autoindent
set ignorecase
set smartcase
set hlsearch
set tabstop=4
set termguicolors
colorscheme codedark

set path+=**
set wildmenu
set wildmode=longest,full

" Cursor line
set cursorline
set cursorcolumn
highlight CursorLine ctermbg=Yellow cterm=bold guibg=#2b2b2b
highlight CursorColumn ctermbg=Yellow cterm=bold guibg=#2b2b2b

" Mapping a better way to move between the splits in vim
nnoremap <leader>l <C-w>l
nnoremap <leader>k <C-w>k
nnoremap <leader>j <C-w>j
nnoremap <leader>h <C-w>h

" Importing Netrw settings
source ~/.vim/plug-config/netrw.vim

" Importing coc settings
source ~/.vim/plug-config/coc-config.vim
