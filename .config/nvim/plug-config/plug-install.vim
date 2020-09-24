" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Plugin installation
call plug#begin('~/.local/share/nvim/plugged')
    " Autocompletion plugins
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Colorscheme
    "Plug 'tomasiser/vim-code-dark'
    Plug 'chriskempson/base16-vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Vim colorizer
    Plug 'norcalli/nvim-colorizer.lua'

    " Vim movements
    Plug 'unblevable/quick-scope'
    Plug 'justinmk/vim-sneak'
    Plug 'liuchengxu/vim-which-key'

    " FZF
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
call plug#end()
