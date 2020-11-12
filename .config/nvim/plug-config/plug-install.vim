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

    " Autocompletion plugins
    "Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " language server
    Plug 'prabirshrestha/vim-lsp'
    Plug 'prabirshrestha/async.vim'
    Plug 'mattn/vim-lsp-settings'

    " auto completions
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'

    " Colorscheme
    Plug 'chriskempson/base16-vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Vim colorizer
    Plug 'norcalli/nvim-colorizer.lua'

    " Vim movements
    Plug 'unblevable/quick-scope'
    "Plug 'justinmk/vim-sneak'
    Plug 'liuchengxu/vim-which-key'

    " FZF
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " snippet
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
call plug#end()
