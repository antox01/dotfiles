" Basic vim settings
let mapleader=" "

set nocompatible
"filetype plugin on

set number relativenumber
syntax on

set hidden                  " Required for multiple buffers
set autoindent
set ignorecase
set smartcase
set smartindent
set incsearch
set hlsearch
set encoding=utf-8
set clipboard=unnamedplus

set noshowmode              " Vim won't show the current active mode

set path+=**
set wildmenu
set wildmode=longest,list

set completeopt=menuone,noinsert,noselect,longest
set shortmess+=c

" === TAB Settings === "
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4


set splitbelow splitright

" Cursor line
set cursorline
set cursorcolumn
