call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-signify'
" Plug 'ervandew/supertab'
Plug 'morhetz/gruvbox'
Plug 'ambv/black'
Plug 'davidhalter/jedi-vim'
Plug 'vim-python/python-syntax'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nnoremap <C-t> :Files<CR>

nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>
vnoremap <C-s> <Esc>:w<CR>

nnoremap <C-q> :q<CR>

nnoremap <leader><leader> <C-^>

nnoremap <leader>cv :e ~/.vimrc<CR>
nnoremap <leader>cg :e ~/.gitconfig<CR>

if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    nnoremap <C-i> :w<CR>
    inoremap <C-i> <Esc>:w<CR>
    vnoremap <C-i> <Esc>:w<CR>
  endif
endif


map ,g :w\|:!go fmt && go run %<cr>
map ,t :w\|:!black % && python3 %<cr>
map ,s :source ~/.vimrc<cr>

set background=dark
set number
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark="hard"
colorscheme gruvbox

set autoread
" set ruler
set ignorecase
set smartcase
set hlsearch
set incsearch
" set lazyredraw
" set magic
" set showmatch
" set mat=2

syntax on
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set autoindent
" set si "Smart indent
" set wrap "Wrap lines
set directory=$HOME/.vimswap//

set winwidth=79
set winminwidth=10
set winheight=999
set winminheight=5
set cursorline


" Highlight long lines
" augroup vimrc_autocmds
"     autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
"     autocmd BufEnter * match OverLength /\%>79v.\+/
" augroup END
" set colorcolumn=80

" Remove trailing whitepace and newlines
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e

set shortmess-=S
