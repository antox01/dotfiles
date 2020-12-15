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

function! CreateInPreview()
  let l:filename = input("please enter filename: ")
  execute 'pedit ' . b:netrw_curdir.'/'.l:filename
endf

function! NetrwMappings()
    noremap <buffer> <C-l> <C-w>l
    noremap <buffer> <A-l> :call ToggleNetrw()<CR>
    noremap <buffer> V :call OpenToRight()<CR>
    noremap <buffer> H :call OpenBelow()<CR>
    noremap <buffer> % :call CreateInPreview()<CR>
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

let g:NetrwIsOpen=0

" Mapping the Netrw toggle keys
nnoremap <A-l> :call ToggleNetrw()<CR>
