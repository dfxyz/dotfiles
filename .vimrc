vim9script
# DF_XYZ's Vim Configurations

# Paths {{{
if has("win32")
  set runtimepath^=$HOME/.vim
  set packpath^=$HOME/.vim
endif
set viminfofile=$HOME/.vim/.viminfo
# }}}

# Filetype & Syntax {{{
filetype plugin indent on
syntax on
# }}}

# Helper Functions {{{
def CharIdx(column: number): number
  return strcharlen(strpart(getline("."), 0, column - 1)) + 1
enddef
# }}}

# Appearance {{{
set background=light
colorscheme CandyPaper

if has("gui_running")
  set guioptions=
  set guifont=Fira_Code:h10
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

def LineAndCharIdx(): string
  const pos = getcurpos()
  const line = pos[1]
  const column = pos[2]
  const charIdx = CharIdx(column)
  return string(line) .. ":" .. string(charIdx)
enddef
&statusline = "%F\ %h%r%m%=%y[%{&fenc}/%{&ff}]%15.{" .. expand("<SID>") .. "LineAndCharIdx()}%10.P"
# }}}

# Basic Keymaps {{{
def InsertModePaste()
  const currentCharIdx = CharIdx(col('.'))
  const lastCharIdx = CharIdx(col('$'))
  var eol = false
  if currentCharIdx >= lastCharIdx - 1
    eol = true
  endif
  if eol
    normal! p
    startinsert!
  else
    normal! gP
  endif
enddef

g:mapleader = " "

nnoremap Y y$
vnoremap p "_dgP
vnoremap P "_dgP
nnoremap <C-S> :update<CR>
inoremap <C-S> <C-O>:update<CR>
vnoremap <C-C> y
nnoremap <C-V> gP
vnoremap <C-V> #_dgP
inoremap <C-V> <C-O>:call <SID>InsertModePaste()<CR>
nnoremap <F4> :tabnew<CR>
nnoremap <C-L> :nohlsearch<CR>
# }}}

# Encoding & EOL {{{
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,latin1

set fileformat=unix
set fileformats=unix,dos
# }}}

# Indent {{{
set autoindent
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
# }}}

# Fold {{{
set foldmethod=syntax
autocmd FileType python setlocal foldmethod=indent
# }}}

# Other Behaviors {{{
set autochdir
set autoread
set backspace=indent,eol,start
set belloff=all
set clipboard=unnamed
set nojoinspaces
# }}}

# LSP {{{
def OnLspBufferEnabled()
  setlocal omnifunc=lsp#complete
  setlocal tagfunc=lsp#tagfunc
  inoremap <buffer> <C-Space> <C-X><C-O>
  nnoremap <buffer> <F2> <plug>(lsp-rename)
  nnoremap <buffer> <F12> <plug>(lsp-document-diagnostics)
  nnoremap <buffer> <C-CR> <plug>(lsp-code-action)
  nnoremap <buffer> <C-M-L> <plug>(lsp-document-format)
  nnoremap <buffer> K <plug>(lsp-hover)
  nnoremap <buffer> gd <plug>(lsp-definition)
  nnoremap <buffer> gD <plug>(lsp-declaration)
  nnoremap <buffer> gr <plug>(lsp-references)
  nnoremap <buffer> gi <plug>(lsp-implementation)
  nnoremap <buffer> gt <plug>(lsp-type-definition)
  nnoremap <buffer> gT <plug>(lsp-type-hierarchy)
  nnoremap <buffer> gs <plug>(lsp-document-symbol-search)
  nnoremap <buffer> gS <plug>(lsp-workspace-symbol-search)
  nnoremap <buffer> [g <plug>(lsp-previous-diagnostic)
  nnoremap <buffer> ]g <plug>(lsp-next-diagnostic)
enddef
augroup LspSetupGroup
  autocmd!
  autocmd User lsp_buffer_enabled call OnLspBufferEnabled()
augroup END
# }}}

# vim: fdm=marker sw=2 ts=2 sts=2
