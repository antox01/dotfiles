" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Plugin installation
call plug#begin('~/.local/share/nvim/plugged')

    " Comments in vim
    Plug 'tpope/vim-commentary'

    " language server
    Plug 'neovim/nvim-lspconfig'

    " auto completions
    Plug 'nvim-lua/completion-nvim'

    " Colorscheme
    Plug 'chriskempson/base16-vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Vim colorizer
    Plug 'norcalli/nvim-colorizer.lua'

    " Vim movements
    Plug 'unblevable/quick-scope'
    Plug 'liuchengxu/vim-which-key'

    " FZF
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " Tree-sitter support
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'
    Plug 'preservim/tagbar'

    " snippet
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
call plug#end()
