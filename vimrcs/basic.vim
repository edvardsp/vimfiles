"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin indent on

" Set to auto read when a file is changed from the outside
set autoread

" Highlight the screen line of the cursor
set cursorline
"
" Disable scrollbars
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" Sane cursor placement of vertical and horizontal splits
set splitbelow
set splitright


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Vim user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set the type of linenumber whether in focus or not
set number
set relativenumber

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the WiLd menu
set wildmenu
set wildmode=longest:full,full
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
set wildignore+=.git\*,.hg\*,.svn\*

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2
"
" Add a bit extra margin to the left
set foldcolumn=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

" Set which keys to allow wrapping
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" Turn persistent undo on means that you can undo even when you close a buffer/vim
exe 'set undodir=' . expand(g:vim_runtime) . '/temp_dirs/undodir'
" set undodir=expand(g:vim_runtime) . '/temp_dirs/undodir'
set undofile


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Sound
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Colors and fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set colorscheme
colorscheme gruvbox
set background=dark

" Enable syntax highlighting, perfer `syntax enable` over `syntax on`
if !exists("g:syntax_on")
    syntax enable
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai   " Auto indent
set si   " Smart indent
set wrap " Wrap lines

" Specify the behavior when switching between buffers
set switchbuf=useopen,usetab,newtab
set stal=2

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Status line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Indentation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NB! option after = must exclude whitespace
set cino+=(s,m1
set cino+=t0
set cino+=g0
set cino+=l1
set cino+=:0
set cino+=N-s


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Helper functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Delete all characters backwards until first slash /
func! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif

    return g:cmd_edited
endfunc

" Return current file dir
func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc
