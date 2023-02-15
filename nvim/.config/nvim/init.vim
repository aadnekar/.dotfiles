lang en_US.utf8
set scrolloff=20
set nu rnu

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent

set encoding=UTF-8

""" Debug mode
let g:vimspector_base_dir=expand( '$HOME/.vim/vimspector-config' )
let g:vimspector_enable_mapping='HUMAN'

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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }


Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax

""" I need emoji's of course 🤓
Plug 'ryanoasis/vim-devicons'

" Debugging
Plug 'puremourning/vimspector'

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
nnoremap <leader><cr> :so $MYVIMRC<cr>

""" New tmux session, with name of folder.
nnoremap <silent> <C-f> :silent !tmux neww tmux-sessionizer<cr>

""" Project View - Open vertically on left side.
nnoremap <leader>pv :Vex<cr>

""" Fuzzy find files for fz
nnoremap <C-p> :GFiles<cr>
nnoremap <leader>pp :Buffers<cr>
nnoremap <C-a-p> :Files<cr>
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
" NeoFormat
let g:prettier#autoformat_config_present = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#exec_cmd_async = 1
let g:neoformat_try_node_exe = 1
let g:neoformat_enabled_typescript = ['prettier']

""" CoC TS JS specific
" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

"Symbol rename
nmap <F2> <Plug>(coc-rename)


""" WORK: BUILD APP DEV
nnoremap  <leader>b :!npm run build:dev<cr>

nnoremap <leader>dd :call vimspector#Launch()<cr>
nnoremap <leader>dc :call vimspector#Continue()<cr>
nnoremap <leader>dr :call vimspector#Reset()<cr>

nnoremap <leader>dl :call vimspector#StepOver()<cr>
nnoremap <leader>dj :call vimspector#StepInto()<cr>
nnoremap <leader>dk :call vimspector#StepOut()<cr>

nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

nnoremap <silent> <F5> :silent !å-debugger<cr>

nnoremap <silent> <leader>B :silent :!npm run build:dev --prefix $LauncherWorkspace && npm run app:debug --prefix $LauncherWorkspace<cr>



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
