lang en_US.utf-8

set scrolloff=12
set relativenumber

set tabstop=4 softtabstop=4
set expandtab
set smartindent

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
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
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>

""" Project View - Open vertically on left side.
nnoremap <leader>pv :Vex<CR>

""" Fuzzy find files
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>pf :Files<CR>

" Quickfix shortcuts
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>
nnoremap <C-E> :copen<CR>

""" Utility movement, VS-Code-like
nnoremap <A-j> ddp
nnoremap <A-k> ddkP
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '>-2<CR>gv=gv

""" Register manipulation
vnoremap <leader>p "_dP
vnoremap <leader>y "+y
" NormalMode-space+y + motion to yank
nnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
