" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

call plug#begin('~/.vim/plugged')
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'tomasiser/vim-code-dark'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
call plug#end()

" Set the leader key for future mapping
let mapleader= ","

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
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h


" Netrw setting for a better position
let g:netrw_banner=0	" Removing the banner
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide=',\(^\|\s\s\)\zs\.\S\+'

