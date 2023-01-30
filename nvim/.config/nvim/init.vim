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

"Plug 'ayu-theme/ayu-vim'
"Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'

" Code Formatting Neo Vim
Plug '/sbdchd/neoformat'

Plug 'tpope/vim-surround'

" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'jsx', 'tsx', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

" Language Server Support
Plug 'dense-analysis/ale'

call plug#end()

set guifont=*
set termguicolors     " enable true colors support
syntax enable
"let ayucolor="dark"   " for dark version of theme
"set background=light
"colorscheme solarized
"colorscheme ayu
colorscheme gruvbox

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
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

""" NEAT!
nnoremap <leader>x :!chmod +x %<cr>

inoremap <C-s> <esc>:w<cr>

""" Trigger formatting
nnoremap <leader>P :Prettier<cr>

""" ALE specific 
nnoremap <leader>d :ALEGoToDefinition<cr>


let g:ale_fixers = {
        \ 'javascript': ['eslint'],
\}

let g:ale_linters = {
        \ 'javascript': ['eslint'],
\}


" Put these lines at the very end of your vimrc file.

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
