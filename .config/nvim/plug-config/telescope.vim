nnoremap <leader>. :Telescope find_files<CR>
nnoremap <leader>b :Telescope buffers<CR>
nnoremap <leader>rc :lua require("telescope.builtin").find_files({ prompt_title = "< VimRC >", cwd = "$HOME/.config/nvim/", })<CR>

lua<<EOF
    require'nvim-treesitter.configs'.setup {
        -- Modules and its options go here
        highlight = { enable = true },
        incremental_selection = { enable = true },
        textobjects = { enable = true },
    }
EOF
