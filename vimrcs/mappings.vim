""""""""""""""""""""""""""""""
" >>>> Leader
""""""""""""""""""""""""""""""

" change leader to ','
let mapleader = ","
let g:mapleader = ","


""""""""""""""""""""""""""""""
" >>>> General Mappings
""""""""""""""""""""""""""""""

" Remove Ex mode
nnoremap Q <nop>

" Fast saving
nmap <leader>w :w!<cr>

" Remove trailing whitespace
nnoremap <leader>rs :%s/\s\+$//e<cr>

" Quick edit of .vimrc and .bashrc
nnoremap <leader>ev :vs ~/.vim_runtime/my_configs.vim<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>eb :vs ~/.bashrc<cr>
nnoremap <leader>sb :source ~/.bashrc<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" $q is super useful when browsing on the command line
" it deletes everything until the last slash
cno $q <C-\>eDeleteTillSlash()<cr>


""""""""""""""""""""""""""""""
" >>>> Buffer Mappings
""""""""""""""""""""""""""""""

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Goto next or previous buffer
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>


""""""""""""""""""""""""""""""
" >>>> Tab Mappings
""""""""""""""""""""""""""""""

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<cr>
noremap <A-h> :-tabmove<cr>
noremap <A-l> :+tabmove<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/


""""""""""""""""""""""""""""""
" >>>> Edit Mappings
""""""""""""""""""""""""""""""

" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif


""""""""""""""""""""""""""""""
" >>>> Ag Search and Cope Mappings
""""""""""""""""""""""""""""""

" Open Ag and put the cursor in the right position
map <leader>g :Ag

" When you press gv you Ag after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with Ag, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Spell checking Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Convenience mappings with spellchecker
" Next misspelled word
map <leader>sn ]s
" Previous misspelled word
map <leader>sp [s
" Add word to dictionary
map <leader>sa zg
" Find suggestions for bad words
map <leader>s? z=


""""""""""""""""""""""""""""""
" >>>> Commands
""""""""""""""""""""""""""""""

" :W sudo saves the file
command W w !sudo tee % > /dev/null

" Delete trailing white space on save, useful for some filestypes
fun! CleanExtraSpaces()
    let save_cursor = getpos('.')
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has('autocmd')
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" Change cursor to beam in insert mode
if has('autocmd')
    au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
    au InsertEnter,InsertChange *
        \ if v:insertmode == 'i' |
        \   silent execute '!echo -ne "\e[6 q"' | redraw! |
        \ elseif v:insertmode == 'r' |
        \   silent execute '!echo -ne "\e[4 q"' | redraw! |
        \ endif
    au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

" Enable syntax highlighting when buffers were loaded through :bufdo, which
" disables the Syntax autocmd event to speed up processing.
augroup EnableSyntaxHighlighting
    " Filetype processing does happen, so we can detect a buffer initially
    " loaded during :bufdo through a set filetype, but missing b:current_syntax.
    " Also don't do this when the user explicitly turned off syntax highlighting
    " via :syntax off.
    " Note: Must allow nesting of autocmds so that the :syntax enable triggers
    " the ColorScheme event. Otherwise, some highlighting groups may not be
    " restored properly.
    autocmd! BufWinEnter * nested if exists('syntax_on') && ! exists('b:current_syntax') && ! empty(&l:filetype) | syntax enable | endif

    " The above does not handle reloading via :bufdo edit!, because the
    " b:current_syntax variable is not cleared by that. During the :bufdo,
    " 'eventignore' contains "Syntax", so this can be used to detect this
    " situation when the file is re-read into the buffer. Due to the
    " 'eventignore', an immediate :syntax enable is ignored, but by clearing
    " b:current_syntax, the above handler will do this when the reloaded buffer
    " is displayed in a window again.
    autocmd! BufRead * if exists('syntax_on') && exists('b:current_syntax') && ! empty(&l:filetype) && index(split(&eventignore, ','), 'Syntax') != -1 | unlet! b:current_syntax | endif
augroup END

