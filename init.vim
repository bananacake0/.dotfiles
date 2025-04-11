" =============================================================================
" .vimrc - macOS-Optimized nvim Configuration
" =============================================================================

" -----------------------------------------------------------------------------
" Plugin Management (vim-plug)
" -----------------------------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')

" Appearance
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Navigation
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Languages
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Markdown
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'dkarter/bullets.vim'

" Visuals
Plug 'chrisbra/Colorizer'
Plug 'ryanoasis/vim-devicons'
Plug 'lervag/vimtex'

call plug#end()

" -----------------------------------------------------------------------------
" General Settings
" -----------------------------------------------------------------------------
set nocompatible
syntax on
filetype plugin indent on
set encoding=utf-8
set number
set ruler
set title
set mouse=a
set clipboard=unnamedplus
set ttymouse=sgr
set wrap linebreak scrolloff=5

" -----------------------------------------------------------------------------
" Appearance
" -----------------------------------------------------------------------------
set background=dark
colorscheme gruvbox

" -----------------------------------------------------------------------------
" Indentation
" -----------------------------------------------------------------------------
set autoindent smartindent
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" -----------------------------------------------------------------------------
" Search
" -----------------------------------------------------------------------------
set ignorecase smartcase hlsearch incsearch

" -----------------------------------------------------------------------------
" Performance & History
" -----------------------------------------------------------------------------
set hidden
set history=1000
set undofile
set undodir=~/.vim/undo
set backup
set backupdir=~/.vim/backup
set noswapfile
set updatetime=300
set shortmess+=c

" -----------------------------------------------------------------------------
" Clipboard (Cmd+C/V Support)
" -----------------------------------------------------------------------------
" Works in GUI Vim (MacVim) and Terminal (if Vim has +clipboard)
vmap <D-c> "+y
vmap <D-v> "+p
nmap <D-v> "+p
imap <D-v> <Esc>"+pa
vmap <C-c> "+y     " Optional: Ctrl+C also copies to clipboard

" -----------------------------------------------------------------------------
" Key Mappings
" -----------------------------------------------------------------------------
let mapleader = ","

" Pane navigation (across splits)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" File ops
nnoremap <Leader>s :w<CR>
nnoremap <Leader>q :q!<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>wq :wq!<CR>

" Tools
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>h :nohlsearch<CR>
nnoremap <Leader>mp :MarkdownPreview<CR>

" -----------------------------------------------------------------------------
" Plugin Configs
" -----------------------------------------------------------------------------

" Airline
let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1

" NERDTree
let g:NERDTreeShowHidden = 1

" CoC (Auto-completion)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Markdown
let g:vim_markdown_folding_disabled = 1
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1

" Colorizer
let g:colorizer_auto_filetype = 'css,html,markdown'

" -----------------------------------------------------------------------------
" Autocommands
" -----------------------------------------------------------------------------
autocmd BufWritePost .vimrc source %
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd FileType markdown,text setlocal spell spelllang=en_us
autocmd CursorHold * silent call CocActionAsync('highlight')

" -----------------------------------------------------------------------------
" End of File
" -----------------------------------------------------------------------------
