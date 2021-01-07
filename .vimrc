call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-fugitive-blame-ext'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-signify'
Plug 'ervandew/supertab'
Plug 'morhetz/gruvbox'
Plug 'ambv/black'
Plug 'davidhalter/jedi-vim'
Plug 'vim-python/python-syntax'
call plug#end()

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nnoremap <C-t> :Files<CR>

map ,g :w\|:!go fmt && go run %<cr>
map ,t :w\|:!black % && python3 %<cr>

set background=dark
set number
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
set directory=$HOME/.vimswap//

" set colorcolumn=80

augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
  autocmd BufEnter * match OverLength /\%>79v.\+/
augroup END
