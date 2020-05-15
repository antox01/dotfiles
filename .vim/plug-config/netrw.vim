" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 20
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide=',\(^\|\s\s\)\zs\.\S\+'

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

" Mapping the Netrw toggle keys
nnoremap <A-l> :call ToggleNetrw()<CR>
