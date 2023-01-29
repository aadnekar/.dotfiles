lang en_US.utf-8

set scrolloff=12
set relativenumber

set tabstop=4
set softtabstop=4
set expandtab
set smartindent

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

""" Will test telescope > fzf
Plug 'junegunn/fzf.vim'

Plug 'ayu-theme/ayu-vim'

" Code Formatting Neo Vim
Plug '/sbdchd/neoformat'

call plug#end()

set termguicolors     " enable true colors support
let ayucolor="dark"   " for dark version of theme
colorscheme ayu

""" Leader key is `Space`
let mapleader = " "

""" Source the init.vim file to get latest changes
nnoremap <leader><cr> :so ~/.config/nvim/init.vim<cr>

""" Project View - Open vertically on left side.
nnoremap <leader>pv :Vex<cr>

""" Fuzzy find files for fzf
nnoremap <C-p> :GFiles<cr>
nnoremap <leader>pf :Files<cr>

" Quickfix shortcuts
nnoremap <C-j> :cnext<cr>
nnoremap <C-k> :cprev<cr>
nnoremap <C-E> :copen<cr>

""" Utility movement, VS-Code-like
nnoremap <A-j> ddp
nnoremap <A-k> ddkP
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '>-2<cr>gv=gv

""" Register manipulation
vnoremap <leader>p "_dP
vnoremap <leader>y "+y
" NormalMode-space+y + motion to yank
nnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

""" NEAT!
nnoremap <leader>x :!chmod +x %<cr>
