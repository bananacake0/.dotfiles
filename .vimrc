" =============================================================================
" Enhanced .vimrc for general editing and development (Updated: December 2025)
" Optimized for Ubuntu + modern Vim/Neovim, recon workflows, markdown, and CoC
" =============================================================================

" -----------------------------------------------------------------------------
" Plugin Management (vim-plug)
" -----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" Appearance
Plug 'morhetz/gruvbox'                              " Gruvbox colorscheme
Plug 'vim-airline/vim-airline'                      " Status/tabline
Plug 'vim-airline/vim-airline-themes'               " Airline themes

" File Navigation
Plug 'preservim/nerdtree'                           " File explorer
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finder
Plug 'junegunn/fzf.vim'                             " Fzf Vim integration

" Git Integration
Plug 'tpope/vim-fugitive'                           " Git commands
Plug 'airblade/vim-gitgutter'                       " Git diff indicators

" Editing Enhancements
Plug 'tpope/vim-surround'                           " Surround text objects
Plug 'tpope/vim-commentary'                         " Easy commenting
Plug 'tpope/vim-repeat'                             " Better . repeat support

" Language Support
Plug 'sheerun/vim-polyglot'                         " Syntax for many languages

" Markdown Support
Plug 'plasticboy/vim-markdown'                      " Markdown syntax
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }
Plug 'dkarter/bullets.vim'                          " Better bullets/lists in markdown

" Utilities
Plug 'chrisbra/Colorizer'                           " Color code highlighter
Plug 'ryanoasis/vim-devicons'                       " File icons (requires nerd font)
Plug 'lervag/vimtex'                                " LaTeX support (optional)
Plug 'ojroques/vim-oscyank'                         " Clipboard over SSH (OSC 52)

" Auto Completion & LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " Conquer of Completion

call plug#end()

" -----------------------------------------------------------------------------
" Basic Settings
" -----------------------------------------------------------------------------
set nocompatible            " Disable Vi compatibility
syntax on                   " Enable syntax highlighting
filetype plugin indent on   " Enable filetype detection
set encoding=utf-8          " UTF-8 everywhere
set fileencoding=utf-8

" -----------------------------------------------------------------------------
" Display & UI
" -----------------------------------------------------------------------------
set number                  " Show line numbers
set showcmd                 " Show partial commands
set showmode                " Show current mode
set ruler                   " Show cursor position
set cursorline              " Highlight current line
set wrap                    " Wrap long lines
set linebreak               " Break at words
set scrolloff=8             " Keep 8 lines visible when scrolling
set sidescrolloff=5
set list                    " Show invisible chars
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¬,precedes:«,extends:»

" Toggle invisible chars
nnoremap <Leader>l :set list!<CR>

" -----------------------------------------------------------------------------
" Colorscheme
" -----------------------------------------------------------------------------
set background=dark
set termguicolors           " Enable true colors (important for gruvbox)
colorscheme gruvbox

" Fix True Color support in tmux
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" -----------------------------------------------------------------------------
" Indentation
" -----------------------------------------------------------------------------
set expandtab               " Use spaces instead of tabs
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
set smartindent

" -----------------------------------------------------------------------------
" Search
" -----------------------------------------------------------------------------
set ignorecase
set smartcase
set hlsearch
set incsearch
nnoremap <silent> <Leader>h :nohlsearch<CR>  " Clear search highlight

" -----------------------------------------------------------------------------
" Mouse & Clipboard
" -----------------------------------------------------------------------------
set mouse=a                 " Enable mouse in all modes

" Sync with system clipboard using OSC 52 (works with -clipboard)
autocmd TextYankPost * if v:event.operator is 'y' && v:event.reg is '' | OSCYankReg " | endif

" Modern bracketed paste (fixes pasting without messing indentation)
if has('patch-8.0.0238') || has('nvim')
    let &t_BE = "\e[?2004h"
    let &t_BD = "\e[?2004l"
    let &t_PS = "\e[200~"
    let &t_PE = "\e[201~"
endif

" -----------------------------------------------------------------------------
" Behavior
" -----------------------------------------------------------------------------
set hidden                  " Allow hidden buffers
set undofile                " Persistent undo
set undodir=~/.vim/undo//
set backup                  " Enable backups
set backupdir=~/.vim/backup//
set noswapfile              " No swap files
set history=1000
set updatetime=300          " Faster completion & gitgutter
set shortmess+=c            " Don't pass messages to ins-completion-menu
set wildignore+=*.o,*.obj,.git,node_modules/,__pycache__/,*.pyc

" Auto-reload vimrc when saved
autocmd BufWritePost $MYVIMRC source % | echom "vimrc reloaded"

" Spell check for text files
autocmd FileType markdown,text,gitcommit setlocal spell spelllang=en_us

" -----------------------------------------------------------------------------
" Key Mappings
" -----------------------------------------------------------------------------
let mapleader=","

" Essentials
nnoremap <Leader>w  :w<CR>
nnoremap <Leader>wq :wq!<CR>
nnoremap <Leader>q  :q!<CR>
nnoremap <Leader>n  :NERDTreeToggle<CR>
nnoremap <Leader>f  :Files<CR>                  " fzf files
nnoremap <Leader>b  :Buffers<CR>                " fzf buffers
nnoremap <Leader>s :%!sort -u<CR>              " Sort + uniq current buffer

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Markdown preview toggle
nnoremap <Leader>mp :MarkdownPreviewToggle<CR>

" -----------------------------------------------------------------------------
" Plugin-specific Settings
" -----------------------------------------------------------------------------

" Airline
let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1               " Use powerline symbols if font supports

" NERDTree
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinPos = "left"
let g:NERDTreeWinSize = 35

" Colorizer (highlight color codes)
let g:colorizer_auto_filetype = 'css,scss,html,markdown,vim'

" Markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_math = 1
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'javascript', 'json']
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_theme = 'dark'

" -----------------------------------------------------------------------------
" CoC Configuration (Modern & Reliable)
" -----------------------------------------------------------------------------
" Recommended extensions (install with :CocInstall)
let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-pyright',
    \ 'coc-prettier',
    \ 'coc-eslint',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-tsserver',
    \ 'coc-yaml',
    \ 'coc-snippets',
    \ 'coc-marketplace',
    \ 'coc-git'
    \ ]

" Better <Tab> completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Confirm completion with Enter (supports snippets)
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
                              \ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Show documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight symbol on cursor hold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <Leader>rn <Plug>(coc-rename)

" Format selected code
xmap <Leader>f  <Plug>(coc-format-selected)
nmap <Leader>f  <Plug>(coc-format-selected)

" =============================================================================
" End of .vimrc
" =============================================================================
