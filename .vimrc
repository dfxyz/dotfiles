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

    set colorcolumn=80
    autocmd FileType java,html,xml setlocal colorcolumn=120
" }

" GUI: {
    autocmd GUIEnter * set t_vb=

    if has("gui_running")
        if has("win32")
            source $VIMRUNTIME/delmenu.vim
            source $VIMRUNTIME/menu.vim
        endif

        if has("win32")
            set guifont=Ubuntu_Mono:h12
        else
            set guifont=Ubuntu\ Mono\ 12
        endif

        set columns=84 lines=40
        function s:set_columns()
            let l:columns = &colorcolumn
            if &number
                let l:numberwidth = float2nr(log10(line("$"))) + 2
                let l:columns += max([&numberwidth, l:numberwidth])
            endif
            if l:columns > &columns
                let &columns = l:columns
            endif
        endfunction
        autocmd BufRead * call s:set_columns()
        autocmd OptionSet colorcolumn call s:set_columns()

        set guioptions-=m
        set guioptions-=e
        set guioptions-=T
    endif
" }

" Keymaps: {
    noremap <C-S> :update<CR>
    inoremap <C-S> <C-O>:update<CR>
    vnoremap <C-X> x
    vnoremap <C-C> y
    nnoremap <C-V> P
    inoremap <C-V> <C-O>P
    nnoremap Y y$
    nnoremap <silent> <F4> :tabnew<CR>
" }

" vim: fdm=marker fmr={,}
