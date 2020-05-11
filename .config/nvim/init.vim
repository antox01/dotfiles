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
set smartindent
set incsearch
set hlsearch
set encoding=utf-8

set path+=**
set wildmenu
set wildmode=longest,list

set completeopt=menuone,longest

set termguicolors
colorscheme codedark

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
let g:Hexokinase_highlighters = ['backgroundfull']
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
	noremap <buffer> <C-l> <C-w>l
	noremap <buffer> <A-l> :call ToggleNetrw()<CR>
	noremap <buffer> V :call OpenToRight()<CR>
	noremap <buffer> H :call OpenBelow()<CR>
endfunction

augroup netrw_mappings
	autocmd!
	autocmd filetype netrw call NetrwMappings()
augroup END

function! ToggleNetrw()
	if g:NetrwIsOpen
		let i = bufnr("$")
		while (i >= 1)
			if (getbufvar(i, "&filetype") == "netrw")
				silent exe "bwipeout " . i
			endif
			let i-=1
		endwhile
		let g:NetrwIsOpen=0
	else
		let g:NetrwIsOpen=1
		silent Lexplore
	endif
endfunction

" Check before opening buffer on any file
function! NetrwOnBufferOpen()
	if exists('b:noNetrw')
		return
	endif
	call ToggleNetrw()
endfunction

" Close Netrw if it's the only buffer open
autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif

augroup ProjectDrawer
	autocmd!
	" Don't open Netrw for this files
	autocmd VimEnter */.git/COMMIT_EDITMSG let b:noNetrw=1

	" For any other files or folder Netrw will be opened
	autocmd VimEnter * :call NetrwOnBufferOpen()
augroup END

let g:NetrwIsOpen=0
