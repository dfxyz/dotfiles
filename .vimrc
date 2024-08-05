" DF_XYZ's Vim Configurations

" Paths {{{
set runtimepath^=$HOME/.vim
let &packpath = &runtimepath
if !has("nvim")
  set viminfofile=$HOME/.cache/viminfo
endif

let s:plugin_dir = "~/.vim/pack/default/start/"
function s:plugin_exists(name) abort
  return !empty(glob(expand(s:plugin_dir) . a:name))
endfunction
" }}}

" Filetype & Syntax {{{
filetype plugin indent on
syntax on
" }}}

" Appearance {{{
if <SID>plugin_exists("CandyPaper.vim")
  colorscheme CandyPaper
endif

if has("gui_running")
  set guioptions=
  set guifont=Fira\ Code:h10
  set columns=125
  set lines=50
  if exists("g:neovide")
    set guifont=Fira\ Code\ Retina:h10
  endif
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
nnoremap <F4> :tabnew<CR>
nnoremap <C-L> :nohlsearch<CR>
nnoremap <C-F12> :terminal<CR>

if <SID>plugin_exists("nerdtree")
  nnoremap <silent> <F3> :NERDTreeToggle<CR>
  nnoremap <silent> <leader>nf :NERDTreeFind<CR>
endif

if <SID>plugin_exists("coc.nvim")
  nnoremap <silent> K :call CocActionAsync("doHover")<CR>

  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"
  inoremap <silent><expr> <C-Space> coc#refresh()

  nnoremap <silent> [d <Plug>(coc-diagnostic-prev)
  nnoremap <silent> ]d <Plug>(coc-diagnostic-next)
  nnoremap <silent> [e <Plug>(coc-diagnostic-prev-error)
  nnoremap <silent> ]e <Plug>(coc-diagnostic-next-error)

  nnoremap <silent> gd <Plug>(coc-definition)
  nnoremap <silent> gD <Plug>(coc-declaration)
  nnoremap <silent> gi <Plug>(coc-implementation)
  nnoremap <silent> gt <Plug>(coc-type-definition)
  nnoremap <silent> gr <Plug>(coc-references)
  nnoremap <silent> gs :CocList symbols<CR>

  nnoremap <silent> <F2> :call CocActionAsync("rename")<CR>
  nnoremap <silent> <S-F6> :call CocActionAsync("refactor")<CR>

  nnoremap <silent> <leader>fm <Plug>(coc-format)
  vnoremap <silent> <leader>fm <Plug>(coc-format-selected)
  nnoremap <silent> <leader>fi :call CocActionAsync("organizeImport")<CR>

  nnoremap <silent> <M-CR> <Plug>(coc-codeaction-cursor)

  function s:toggle_outline() abort
    let winid = coc#window#find("cocViewId", "OUTLINE")
    if winid == -1
      call CocActionAsync("showOutline", 1)
    else
      call coc#window#close(winid)
    endif
  endfunction
  nnoremap <silent> <F6> :call <SID>toggle_outline()<CR>

  nnoremap <silent> <leader>ci :call CocActionAsync("showIncomingCalls")<CR>
  nnoremap <silent> <leader>co :call CocActionAsync("showOutgoingCalls")<CR>
  nnoremap <silent> <leader>ti :call CocActionAsync("showSuperTypes")<CR>
  nnoremap <silent> <leader>to :call CocActionAsync("showSubTypes")<CR>
endif
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
set shiftwidth=0
" }}}

" Fold {{{
set foldmethod=syntax
set foldlevel=999
" }}}

" Other Behaviors {{{
set autochdir
set autoread
set backspace=indent,eol,start
set belloff=all
set clipboard=unnamed
set nobackup
set nojoinspaces
set noswapfile
" }}}

" Local Configurations {{{
if filereadable(expand("$HOME/.vimrc_local"))
  source $HOME/.vimrc_local
endif
" }}}

" vim: fdm=marker ts=2
