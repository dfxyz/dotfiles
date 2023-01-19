" DF_XYZ's Vim Configurations

" Paths {{{
set runtimepath^=$HOME/.vim
let &packpath = &runtimepath
if !has("nvim")
  set viminfofile=$HOME/.vim/.viminfo
endif
" }}}

" Filetype & Syntax {{{
filetype plugin indent on
syntax on
" }}}

" Appearance {{{
colorscheme CandyPaper

if has("gui_running")
  set guioptions=
  set guifont=Fira\ Code:h10
  set columns=125
  set lines=50
else 
  set termguicolors
  set t_8f=[38;2;%lu;%lu;%lum
  set t_8b=[48;2;%lu;%lu;%lum
endif

set hlsearch
set incsearch

set number
set signcolumn=number
set cursorline
set showcmd
set showmatch
set wildmenu

set laststatus=2
set shortmess=filnxtToOF

function! s:char_index(column)
  return strchars(strpart(getline("."), 0, a:column - 1)) + 1
endfunction
function! s:line_and_char_index()
  let pos = getcurpos()
  let line = pos[1]
  let column = pos[2]
  let charIdx = s:char_index(column)
  return string(line) .. ":" .. string(charIdx)
endfunction
let &statusline = "%F\ %h%r%m%=%y[%{&fenc}/%{&ff}]%15.{" .. expand("<SID>") .. "line_and_char_index()}%10.P"

let s:syntax_value = ""
function! s:save_syntax()
  let s:syntax_value = &l:syntax
endfunction
function! s:restore_syntax()
  let &l:syntax = s:syntax_value
endfunction
augroup ApplySyntaxHighlighting
  autocmd ColorSchemePre * call s:save_syntax()
  autocmd ColorScheme * call s:restore_syntax()
augroup END

" }}}

" Basic Keymaps {{{
function! s:insert_mode_paste()
  return @+ " todo: not working if contains escape characters
endfunction

let g:mapleader = " "

nnoremap Y y$
vnoremap p "_dgP
vnoremap P "_dgP
nnoremap <C-S> :update<CR>
inoremap <C-S> <C-O>:update<CR>
vnoremap <C-C> y
nnoremap <C-V> gP
vnoremap <C-V> "_dgP
inoremap <expr> <C-V> <SID>insert_mode_paste()
nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <F4> :tabnew<CR>
nnoremap <C-L> :nohlsearch<CR>
" }}}

" Encoding & EOL {{{
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,latin1

set fileformat=unix
set fileformats=unix,dos
" }}}

" Indent {{{
set autoindent
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" }}}

" Fold {{{
set foldmethod=syntax
set foldlevel=999
" }}}

" Other Behaviors {{{
let g:is_bash = 1

set autochdir
set autoread
set backspace=indent,eol,start
set belloff=all
set clipboard=unnamed
set nojoinspaces
" }}}

" Local Configurations {{{
if filereadable(expand("$HOME/.vimrc_local"))
  source $HOME/.vimrc_local
endif
" }}}

" vim: fdm=marker sw=2 ts=2 sts=2
