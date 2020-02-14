call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-signify'
Plug 'ervandew/supertab'
Plug 'phanviet/vim-monokai-pro'
Plug 'morhetz/gruvbox'
Plug 'danilo-augusto/vim-afterglow'
" Plug 'sheerun/vim-polyglot'
Plug 'ambv/black'
Plug 'davidhalter/jedi-vim'
Plug 'vim-python/python-syntax'
call plug#end()

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nnoremap <leader>t :Files<CR>

set background=dark
set number
" colorscheme afterglow
" let g:afterglow_blackout=1
" let g:afterglow_italic_comments=1
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark="hard"
colorscheme gruvbox

" set autoread
" set ruler
set ignorecase
set smartcase
set hlsearch
set incsearch
" set lazyredraw
" set magic
" set showmatch
" set mat=2

" syntax enable
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
" set ai "Auto indent
" set si "Smart indent
" set wrap "Wrap lines

