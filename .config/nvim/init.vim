set nocompatible

call plug#begin('~/.local/share/nvim/plugged')
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'tomasiser/vim-code-dark'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
	Plug 'unblevable/quick-scope'
call plug#end()
filetype plugin on

set number relativenumber
syntax on
set autoindent
set ignorecase
set smartcase
set incsearch
set hlsearch
set encoding=utf-8

set path+=**
set wildmenu
set wildmode=longest,list

set termguicolors
colorscheme codedark

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
let g:Hexokinase_highlighters = ['virtual']
" Reenable hexokinase on enter
autocmd VimEnter * HexokinaseToggle

" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 20

function! OpenToRight()
	:normal v
	let g:path=expand('%:p')
	:q!
	execute 'belowright vnew' g:path
	:normal <C-w>l
endfunction

function! OpenBelow()
	:normal v
	let g:path=expand('%:p')
	:q!
	execute 'belowright new' g:path
	:normal <C-w>l
endfunction

function! NetrwMappings()
	 noremap <buffer> <A-l> <C-w>l
	 noremap <buffer> <C-l> <C-w>l
	 noremap <buffer> <A-l> :call ToggleNetrw()<CR> 
	 noremap <buffer> V :call OpenToRight()<CR> 
	 noremap <buffer> V :call OpenBelow()<CR>
endfunction

augroup netrw_mappings
	autocmd!
	autocmd filetype netrw call NetrwMappings()
augroup END

