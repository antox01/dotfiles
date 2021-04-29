" Mapping a better way to move between the splits in vim
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h

" In insert move remap <C-c> to ESC
inoremap <C-c> <Esc>

" Terminal remapping
tnoremap <Esc> <C-\><C-n>

" Quickfix list
nnoremap <C-q> :call ToggleQFList(1)<CR>
nnoremap <leader>qn :cnext<CR>
nnoremap <leader>qp :cNext<CR>

let g:qf_opened = 0
let g:qfl_opened = 0

function! ToggleQFList(global)
    if a:global
        if g:qf_opened
            let g:qf_opened = 0
            cclose
        else
            let g:qf_opened = 1
            copen
        end
    else
        if g:qfl_opened
            let g:qfl_opened = 0
            lclose
        else
            let g:qfl_opened = 1
            lopen
        endif
    endif
endfunction
