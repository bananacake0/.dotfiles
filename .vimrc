" =============================================================================
" Enhanced .vimrc for general editing
" =============================================================================

" -----------------------------------------------------------------------------
" Plugin Management (vim-plug)
" -----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" Appearance
Plug 'morhetz/gruvbox'                           " Gruvbox colorscheme
Plug 'vim-airline/vim-airline'                   " Status/tabline
Plug 'vim-airline/vim-airline-themes'            " Airline themes

" File Navigation
Plug 'preservim/nerdtree'                        " File explorer
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " Fuzzy finder
Plug 'junegunn/fzf.vim'                          " Fzf Vim integration

" Git Integration
Plug 'tpope/vim-fugitive'                        " Git commands
Plug 'airblade/vim-gitgutter'                    " Git diff indicators

" Editing Enhancements
Plug 'tpope/vim-surround'                        " Surround text objects
Plug 'tpope/vim-commentary'                      " Easy commenting

" Language Support (syntax only)
Plug 'sheerun/vim-polyglot'                      " Language pack for syntax

" Markdown Support
Plug 'plasticboy/vim-markdown'                   " Markdown syntax
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'dkarter/bullets.vim'                       " Smart bullets

" Unicode & Icons
Plug 'chrisbra/Colorizer'                        " Color highlighter
Plug 'ryanoasis/vim-devicons'                    " File icons
Plug 'lervag/vimtex'                             " LaTeX support (optional)

" Auto Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'} " CoC for autocompletion

call plug#end()

" -----------------------------------------------------------------------------
" Basic Settings
" -----------------------------------------------------------------------------
set nocompatible          " Disable Vi compatibility
syntax on                 " Enable syntax highlighting
filetype plugin indent on " Filetype-specific settings
set encoding=utf-8        " UTF-8

" -----------------------------------------------------------------------------
" Display
" -----------------------------------------------------------------------------
set number                " Line numbers
set showcmd               " Show partial commands
set showmode              " Show mode (INSERT, VISUAL)
set ruler                 " Show cursor position
set wrap                  " Wrap long lines
set linebreak             " Wrap on word boundary
set scrolloff=5           " Keep context when scrolling
set cursorline            " Highlight current line

" -----------------------------------------------------------------------------
" Colorscheme
" -----------------------------------------------------------------------------
set background=dark       " Dark background
colorscheme gruvbox       " Use Gruvbox

" -----------------------------------------------------------------------------
" Indentation
" -----------------------------------------------------------------------------
set expandtab             " Spaces instead of tabs
set shiftwidth=4          " Indent size
set softtabstop=4         " Tab key size
set tabstop=4             " Tab width
set autoindent            " Copy indent
set smartindent           " Smart indentation

" -----------------------------------------------------------------------------
" Search Behavior
" -----------------------------------------------------------------------------
set ignorecase            " Case-insensitive
set smartcase             " Case-sensitive if uppercase used
set hlsearch              " Highlight matches
set incsearch             " Incremental search

" -----------------------------------------------------------------------------
" Mouse & Clipboard
" -----------------------------------------------------------------------------
set mouse=a               " Enable mouse
set clipboard=unnamedplus " System clipboard

" -----------------------------------------------------------------------------
" Key Mappings
" -----------------------------------------------------------------------------
let mapleader=","        " Leader key
nnoremap <Leader>s :w!<CR>  " Save
nnoremap <Leader>q :q!<CR> " Quit
nnoremap <Leader>wq :wq!<CR>" Save & Quit
nnoremap <Leader>n :NERDTreeToggle<CR>  " Toggle NERDTree
nnoremap <Leader>h :nohlsearch<CR>      " Clear search

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Markdown Preview
nnoremap <Leader>mp :MarkdownPreviewToggle<CR>

" Toggle Paste Mode
nnoremap <Leader>p :set paste!<CR>       " Toggle paste mode (for external pasting)
imap <Leader>p <C-o>:set paste!<CR>     " In insert mode, toggle and return to insert

" -----------------------------------------------------------------------------
" Plugin-specific Settings
" -----------------------------------------------------------------------------

" vim-airline
let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1

" NERDTree
let g:NERDTreeShowHidden = 1

" Colorizer
let g:colorizer_auto_filetype = 'css,html,markdown'

" Markdown
let g:vim_markdown_folding_disabled = 1
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1

" CoC settings
" Use <tab> for completion and navigate completion list
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~ '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `gd` for go-to-definition, `gy` for go-to-type-definition, `gr` for go-to-references
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol under the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use K to show documentation in preview window
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

" -----------------------------------------------------------------------------
" General Behavior
" -----------------------------------------------------------------------------
set hidden                " Allow buffer switching without save
set undofile              " Persistent undo
set undodir=~/.vim/undo   " Undo directory
set backup                " Enable backup
set backupdir=~/.vim/backup
set noswapfile            " Disable swapfile
set history=1000          " Command history

" Auto-reload vimrc on save
autocmd BufWritePost .vimrc source %

" Enable spell check for text
autocmd FileType markdown,text setlocal spell spelllang=en_us

" END OF .vimrc
" =============================================================================
