nnoremap <leader>. :Telescope find_files<CR>
nnoremap <leader>b :Telescope buffers<CR>
nnoremap <leader>rc :lua require("telescope.builtin").find_files({ prompt_title = "< VimRC >", cwd = "$HOME/.config/nvim/", })<CR>
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>

