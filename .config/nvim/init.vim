" Basic vim settings
let mapleader=" "

set nocompatible
filetype plugin on

set number relativenumber
syntax on
set autoindent
set ignorecase
set smartcase
set smartindent
set incsearch
set hlsearch
set encoding=utf-8

set path+=**
set wildmenu
set wildmode=longest,list

set completeopt=menuone,longest

" Plugin installation
call plug#begin('~/.local/share/nvim/plugged')
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'tomasiser/vim-code-dark'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
	Plug 'unblevable/quick-scope'
call plug#end()

set termguicolors
colorscheme codedark

" Importing the settings of coc
source ~/.config/nvim/plug-config/coc-config.vim
" Importing the settings of Netrw
source ~/.config/nvim/plug-config/netrw.vim

" Cursor line
set cursorline
set cursorcolumn
highlight CursorLine ctermbg=Yellow cterm=bold guibg=#2b2b2b
highlight CursorColumn ctermbg=Yellow cterm=bold guibg=#2b2b2b

" Mapping a better way to move between the splits in vim
nnoremap <Leader>l <C-w>l
nnoremap <Leader>k <C-w>k
nnoremap <Leader>j <C-w>j
nnoremap <Leader>h <C-w>h

" QuickScope Highlighting
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline

" Vim-airline
let g:airline#extensions#wordcount#enable = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline_theme = 'codedark'

" Remap ESC to ii
:imap ii <ESC>
" Remap ESC to jk
:imap jk <ESC>
" Remap ESC to jj
:imap jj <ESC>

" Vim Hexokinase
let g:Hexokinase_refreshEvents = ['InsertLeave']
let g:Hexokinase_optInPatterns = [
\     'full_hex',
\     'triple_hex',
\     'rgb',
\     'rgba',
\     'hsl',
\     'hsla',
\     'colour_names'
\ ]

let g:Hexokinase_highlighters = ['backgroundfull']
" Reenable hexokinase on enter
autocmd VimEnter * HexokinaseToggle

