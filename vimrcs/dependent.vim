""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Terminal vs Gui
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" >> Terminal Vim
if !has('gui_running')
    " Quickfix for <C-w> in terminal vim
    noremap! <C-BS> <C-w>
    noremap! <C-h> <C-w>

" >> Gui Vim (gVim)
else
    " Set the default font type and size
    set guifont=Source\ Code\ Pro:h9
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Vim vs Neovim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" >> Vim
if !has('nvim')
    if !has('gui_running')
        " Fix Meta key (Alt) bindings issue in terminal
        let c = 'a'
        while c <= 'z'
            exec "set <A-".c.">=\e".c
            exec "imap \e".c." <A-".c.">"
            let c = nr2char(1+char2nr(c))
        endw
        set timeout ttimeoutlen=50
    endif

" >> Neovim
else
    " Set true type colors
    set t_8f=^[[38;2;%lu;%lu;%lum  " Needed in tmux
    set t_8b=^[[48;2;%lu;%lu;%lum  " Ditto
    " BUT! not in TMUX, becuase of bug
    " https://github.com/neovim/neovim/issues/7041
    if !exists('$TMUX')
        set termguicolors
    endif

    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    let $NVIM_TUE_ENABLE_CURSOR_SHAPE=1

    " set terminal mappings
    tnoremap <C-h> <C-\><C-N><C-w>h
    tnoremap <C-j> <C-\><C-N><C-w>j
    tnoremap <C-k> <C-\><C-N><C-w>k
    tnoremap <C-l> <C-\><C-N><C-w>l

    " Set python paths
    let g:python_host_prog = "/usr/bin/python2"
    let g:python3_host_prog = "/usr/bin/python3"
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> MacVim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_macvim")
    " Properly disable sound on errors on MacVim
    autocmd GUIEnter * set vb t_vb=
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Gnome Terminal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if $COLORTERM == 'gnome-terminal'
    " Set color type
    set t_Co=256
endif
