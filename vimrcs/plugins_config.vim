""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> bufExplorer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> MRU
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let MRU_Max_Entries = 400
map <leader>f :MRU<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Yankstack
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <c-p> <Plug>yankstack_substitute_older_paste
nmap <c-P> <Plug>yankstack_substitute_newer_paste


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> CTRL-P
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ctrlp_working_path_mode = 0

let g:ctrlp_map = '<c-f>'
map <leader>j :CtrlP<cr>
map <c-b> :CtrlPBuffer<cr>

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Zen coding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable all functions in all modes
let g:user_zen_mode='a'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> snipMate (beside <Tab> support <C-j>)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

ino <c-j> <c-r>=snipMate#TriggerSnippet()<cr>
snor <c-j> <esc>i<right><c-r>=snipMate#TriggerSnippet()<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Vim grep
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Nerd Tree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Vim Multiple Cursors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:multi_cursor_next_key="\<C-s>"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> surround.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Lightline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'filename', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Vimroom
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Vim-go
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:go_fmt_command = "goimports"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Syntastics
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Python
let g:syntastic_python_checkers=['pyflakes']

" Go
let g:syntastic_auto_loc_list = 1
let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Git-gutter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gitgutter_enabled=0
nnoremap <silent> <leader>d :GitGutterToggle<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> YouCompleteMe (YCM)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '/home/edvardsp/.ycm_global_conf.py'
let g:ycm_extra_conf_vim_data = ['&filetype']
let g:ycm_seed_identifiers_with_syntax = 1
"let g:ycm_enable_diagnostics_signs = 0
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '~~'

" ycm debug purposes
let g:ycm_server_use_vim_stdout = 1
let g:ycm_server_log_level = 'debug'

" For racerd. NB! full path must be specified.
let g:rust_src_path='/home/edvardsp/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/'

" YCM shortcuts
nnoremap <F9> :YcmCompleter FixIt<cr>
nnoremap <F5> :YcmCompleter GoTo<cr>
nnoremap <F6> :YcmCompleter GetDoc<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> AutoPairs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'
augroup vimrc-rust-autopairs
    autocmd!
    autocmd FileType rust let g:AutoPairs = {'(':')', '[':']', '{':'}', '"':'"', '`':'`'}
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Mesonic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let b:meson_command = 'meson'
let b:meson_ninja_command = 'ninja'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Vim Sessions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set sessionoptions-=help    " don't save help window
let g:session_autoload='no'
let g:session_autosave='yes'
let g:session_autosave_periodic=5 " in minutes
let g:session_autosave_silent=1
let g:session_verbose_messages=1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Cpp Enhanched Highlight
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:cpp_member_variable_highlight=1
let g:cpp_experimental_template_highlight=1
let g:cpp_concepts_highlight=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" >>>> Markdown Preview
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:vim_markdown_preview_github=1


