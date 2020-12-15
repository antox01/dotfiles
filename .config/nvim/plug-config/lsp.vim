"let g:lsp_diagnostics_float_cursor = 1 
let g:lsp_highlights_enabled = 0	" disable highlights on diagnostics
let g:lsp_signs_enabled = 1	" enable signs
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}
let g:lsp_signs_hint = {'text': '?'}

nmap <silent> gd <plug>(lsp-definition)
nmap <silent> gy <plug>(lsp-declaration)
nmap <silent> gi <plug>(lsp-implementation)
"nmap <silent> gy :LspDefinition

nmap <leader>rn <plug>(lsp-rename)

" asyncomplete
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
