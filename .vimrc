" DF_XYZ's Vim Configuration

" General: {
    if has("win32")
        set runtimepath^=$HOME/.vim
        set packpath^=$HOME/.vim
    endif

    set nocompatible

    filetype plugin indent on
    syntax on

    set autoread
    set autochdir
    set noswapfile
    set nobackup
    set nowritebackup
    set backspace=2
    set wildmenu
    set clipboard^=unnamed
" }

" Encoding: {
    set encoding=utf-8
    set fileencoding=utf-8
    set fileencodings=ucs-bom,utf-8,chinese
    set fileformat=unix
    set fileformats=unix,dos,mac
" }

" Color Scheme: {
    set background=light
    set termguicolors
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    colorscheme CandyPaper
" }
"
" Indent: {
    set autoindent
    set smartindent
    set expandtab
    set shiftwidth=4
    set tabstop=4
    set softtabstop=4
" }

" Code Folding: {
    set foldlevelstart=99
    set foldmethod=indent
    autocmd FileType c,cpp,java,go setlocal foldmethod=syntax
    autocmd FileType css,javascript setlocal foldmethod=marker foldmarker={,}
" }

" UI: {
    set number
    set cursorline
    set ruler
    set incsearch
    set hlsearch
    set showcmd
    set showmatch
    set wildmenu

    set visualbell
    set t_vb=
" }

" GUI: {
    autocmd GUIEnter * set t_vb=

    if has("gui_running")
        if has("win32")
            source $VIMRUNTIME/delmenu.vim
            source $VIMRUNTIME/menu.vim
        endif

        if has("win32")
            set guifont=Fira_Code:h10
        else
            set guifont=Fira\ Code\ 10
        endif

        function s:set_columns(len)
            let l:numberwidth = float2nr(log10(line("$"))) + 2
            let l:numberwidth = max([&numberwidth, l:numberwidth])
            let &columns = a:len + l:numberwidth
        endfunction
        autocmd BufEnter * call s:set_columns(120)

        call s:set_columns(120)
        set lines=60

        set guioptions-=r
        set guioptions-=L
        set guioptions-=m
        set guioptions-=e
        set guioptions-=T
    endif
" }

" Keymaps: {
    noremap <C-S> :update<CR>
    inoremap <C-S> <C-O>:update<CR>
    vnoremap <C-C> y
    nnoremap <C-V> P
    inoremap <C-V> <C-O>P
    nnoremap Y y$
    nnoremap <F4> :tabnew<CR>
    vnoremap p "_dP
    vnoremap P "_dP
" }

" Others: {
    let g:is_bash=1
" }

" vim: fdm=marker fmr={,}
