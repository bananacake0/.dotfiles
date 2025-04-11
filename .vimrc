" =============================================================================
" .vimrc - Vim Configuration File
" =============================================================================

" -----------------------------------------------------------------------------
" Plugin Management (Using vim-plug)
" -----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" Appearance
Plug 'morhetz/gruvbox'             " A beautiful colorscheme
Plug 'vim-airline/vim-airline'     " Status/tabline
Plug 'vim-airline/vim-airline-themes' " Themes for vim-airline

" File Navigation
Plug 'preservim/nerdtree'          " File explorer
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy file finder
Plug 'junegunn/fzf.vim'

" Git Integration
Plug 'tpope/vim-fugitive'          " Git commands in Vim
Plug 'airblade/vim-gitgutter'      " Git diff indicators in the gutter

" Editing Enhancements
Plug 'tpope/vim-surround'          " Easily work with surrounding characters
Plug 'tpope/vim-commentary'        " Comment/uncomment lines easily

" Language Support
Plug 'sheerun/vim-polyglot'        " Better syntax highlighting for many languages
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense engine

" Markdown Support
Plug 'plasticboy/vim-markdown'     " Better Markdown syntax and features
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' } " Live Markdown preview
Plug 'dkarter/bullets.vim'         " Automatically manage bullet points in Markdown

" Unicode and Color Support
Plug 'chrisbra/Colorizer'          " Highlight and preview colors (e.g., #FF0000)
Plug 'ryanoasis/vim-devicons'      " Add file type icons (supports Unicode)
Plug 'lervag/vimtex'               " LaTeX support (optional, for advanced Markdown + math)

call plug#end()

" -----------------------------------------------------------------------------
" Basic Settings
" -----------------------------------------------------------------------------
set nocompatible      " Disable Vi compatibility mode
syntax on             " Enable syntax highlighting
filetype plugin on    " Enable filetype-specific plugins
filetype indent on    " Enable filetype-specific indentation
set encoding=utf-8    " Set encoding to UTF-8

" -----------------------------------------------------------------------------
" Display Settings
" -----------------------------------------------------------------------------
set number            " Show line numbers
set norelativenumber  " Disable relative line numbers (fixes scrolling issues)
set ruler             " Show cursor position (line, column)
set showcmd           " Show partial commands in the status line
set showmode          " Show current mode (e.g., INSERT, VISUAL)
set title             " Set the terminal title to the current file
set wrap              " Wrap long lines
set linebreak         " Wrap at word boundaries
set scrolloff=5       " Keep 5 lines above/below the cursor when scrolling

" -----------------------------------------------------------------------------
" Colorscheme
" -----------------------------------------------------------------------------
set background=dark   " Use dark background
colorscheme gruvbox   " Set colorscheme (requires gruvbox plugin)

" -----------------------------------------------------------------------------
" Indentation
" -----------------------------------------------------------------------------
set autoindent        " Copy indentation from the previous line
set smartindent       " Enable smart indentation
set tabstop=4         " Number of spaces a tab counts for
set shiftwidth=4      " Number of spaces for auto-indent
set softtabstop=4     " Number of spaces for tab in insert mode
set expandtab         " Use spaces instead of tabs

" -----------------------------------------------------------------------------
" Search Settings
" -----------------------------------------------------------------------------
set ignorecase        " Ignore case when searching
set smartcase         " Case-sensitive search if uppercase is used
set hlsearch          " Highlight search results
set incsearch         " Incremental search (search as you type)

" -----------------------------------------------------------------------------
" Mouse Support
" -----------------------------------------------------------------------------
set mouse=a           " Enable mouse in all modes

" Use macOS system clipboard for copy/paste
set clipboard=unnamedplus

" Map Cmd+C / Cmd+V to system clipboard (works in GUI Vim like MacVim)
if has("gui_running")
  vmap <D-c> "+y
  vmap <D-v> "+p
  nmap <D-v> "+p
  imap <D-v> <Esc>"+pa
endif
" -----------------------------------------------------------------------------
" Key Mappings
" -----------------------------------------------------------------------------
let mapleader = ","   " Set the leader key to comma

" Save, Quit, and Save-and-Quit
nnoremap <Leader>s :w<CR>          " Save file
nnoremap <Leader>q :q!<CR>          " Quit Vim
nnoremap <Leader>x :x<CR>          " Save and quit (only if changes were made)
nnoremap <Leader>wq :wq!<CR>        " Save and quit (always)

" NERDTree toggle
nnoremap <Leader>n :NERDTreeToggle<CR>

" Clear search highlights
nnoremap <Leader>h :nohlsearch<CR>

" Move between splits (windows)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Markdown Preview
nnoremap <Leader>mp :MarkdownPreview<CR> " Toggle Markdown preview

" -----------------------------------------------------------------------------
" Plugin-Specific Settings
" -----------------------------------------------------------------------------

" vim-airline
let g:airline_theme = 'gruvbox'    " Set airline theme
let g:airline#extensions#tabline#enabled = 1 " Enable tabline

" NERDTree
let g:NERDTreeShowHidden = 1       " Show hidden files in NERDTree

" coc.nvim (Auto-completion)
" Use <Tab> and <S-Tab> to navigate completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Markdown Settings
let g:vim_markdown_folding_disabled = 1 " Disable Markdown folding
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh'] " Syntax highlighting for code blocks

" Markdown Preview
let g:mkdp_auto_start = 0          " Don't auto-start Markdown preview
let g:mkdp_auto_close = 1          " Auto-close preview when switching buffers

" Colorizer
let g:colorizer_auto_filetype = 'css,html,markdown' " Enable color highlighting for these file types

" -----------------------------------------------------------------------------
" Miscellaneous
" -----------------------------------------------------------------------------
set hidden            " Allow switching buffers without saving
set history=1000      " Increase command history
set undofile          " Enable persistent undo
set undodir=~/.vim/undo " Set undo file directory
set backup            " Enable backups
set backupdir=~/.vim/backup " Set backup directory
set noswapfile        " Disable swap files
let $SSL_CERT_FILE='/usr/local/etc/ca-certificates/cert.pem'
" -----------------------------------------------------------------------------
" Auto Commands
" -----------------------------------------------------------------------------
" Automatically reload .vimrc when it's saved
autocmd BufWritePost .vimrc source %

" Automatically open NERDTree when Vim starts with no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Enable spell check for Markdown and text files
autocmd FileType markdown,text setlocal spell spelllang=en_us

" -----------------------------------------------------------------------------
" coc.nvim Settings
" -----------------------------------------------------------------------------
set hidden
set updatetime=300
set shortmess+=c

" Use <Tab> and <S-Tab> to navigate completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <CR> to confirm completion
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight symbol under cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Rename symbol
nmap <leader>rn <Plug>(coc-rename)

" Format selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Enable word-based completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" -----------------------------------------------------------------------------
" End of .vimrc
" -----------------------------------------------------------------------------
