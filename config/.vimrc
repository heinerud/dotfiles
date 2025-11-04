call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-signify'
Plug 'ervandew/supertab'
Plug 'morhetz/gruvbox'
Plug 'ambv/black'
Plug 'davidhalter/jedi-vim'
Plug 'vim-python/python-syntax'
Plug 'tmux-plugins/vim-tmux-focus-events'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'terryma/vim-multiple-cursors'
call plug#end()

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-l> <C-w>l
nnoremap <C-Right> :tabnext<CR>

nnoremap <C-n> :tabnew<CR>

nnoremap <C-t> :Files<CR>

nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>
vnoremap <C-s> <Esc>:w<CR>

nnoremap <C-q> :q<CR>

nnoremap <leader><leader> <C-^>

nnoremap <leader>cv :e ~/.vimrc<CR>
nnoremap <leader>cg :e ~/.gitconfig<CR>
nnoremap <Leader>" ciw""<Esc>P
nnoremap <Leader>' ciw''<Esc>P
nnoremap <Leader>[ ciw[]<Esc>P
nnoremap <Leader>{ ciw{}<Esc>P
nnoremap <Leader>x o- [ ]

" copy-paste on wayland
" requires wl-clipboard
vnoremap <leader>y :w !wl-copy<CR><CR>
nnoremap <leader>p :r !wl-paste<CR>

nnoremap <leader>g :execute 'Git grep ' . expand('<cword>')<CR>

map ,g :w\|:!go fmt % && go run %<cr>
map ,t :w\|:!python3 %<cr>
map ,b :w\|:!black %<cr>
map ,f :w\|:!flake8 %<cr>
map ,i :w\|:!isort %<cr>
map ,s :source ~/.vimrc<cr>
map <leader>d :SignifyHunkDiff<CR>
map <leader>q :SignifyHunkUndo<CR>


set number
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

set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set autoindent
" set si "Smart indent
" set wrap "Wrap lines
set directory=$HOME/.vimswap//
" set noswapfile

au FocusGained,BufEnter * :checktime

set winwidth=120
set winminwidth=15
set winheight=999
set winminheight=8
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

" let g:jedi#show_call_signatures = "2"

set mouse=a

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'filename': 'LightlineFilename',
      \ },
      \ }

let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
highlight Comment cterm=italic

syntax on
set termguicolors

let g:gruvbox_italic=1
" let g:gruvbox_contrast_dark="hard"
" let g:gruvbox_contrast_light="hard"
set background=dark
colorscheme gruvbox

" colorscheme github
" let g:lightline = { 'colorscheme': 'github' }

" colorscheme vim-material

" colorscheme xcodelight

" colorscheme one
" let g:one_allow_italics=1
