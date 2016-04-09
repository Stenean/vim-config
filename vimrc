" => General {{{
" Sets how many lines of history VIM has to remember
set history=700
set term=xterm-256color
set t_ut=

set nocompatible
filetype off

if $PYTHON_VERSION
    if $PYTHON_VERSION == 3
        python3 import sys
    else
        python import sys
    endif
endif

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'gmarik/Vundle.vim'

Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-session'

Bundle 'vim-scripts/TaskList.vim'
Bundle 'vim-scripts/tComment'
Bundle 'vim-scripts/The-NERD-tree'

Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'

Bundle 'Shougo/neocomplete.vim'
Bundle 'Shougo/context_filetype.vim'
Bundle 'Shougo/neoinclude.vim'
Bundle 'Shougo/neco-syntax'
Bundle 'Shougo/vimproc.vim'

Bundle 'Chiel92/vim-autoformat'
Bundle 'chrisbra/csv.vim'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'davidhalter/jedi-vim'
Bundle 'derekwyatt/vim-fswitch'
Bundle 'edsono/vim-matchit'
Bundle 'ekalinin/Dockerfile.vim'
Bundle 'elzr/vim-json'
Bundle 'fidian/hexmode'
Bundle 'fisadev/vim-isort'
Bundle 'honza/vim-snippets'
Bundle 'hsanson/vim-android'
Bundle 'hynek/vim-python-pep8-indent'
Bundle 'idanarye/vim-vebugger'
Bundle 'justmao945/vim-clang'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'lervag/vimtex'
Bundle 'majutsushi/tagbar'
Bundle 'MarcWeber/vim-addon-local-vimrc'
Bundle 'marijnh/tern_for_vim'
Bundle 'mbbill/undotree'
Bundle 'mhinz/vim-signify'
Bundle 'othree/javascript-libraries-syntax.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'raimondi/delimitmate'
Bundle 'scrooloose/syntastic'
Bundle 'SirVer/ultisnips'
Bundle 'sjl/gundo.vim'
Bundle 'tmhedberg/SimpylFold'
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'

Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

call vundle#end()

let python_highlight_all=1

syntax on

" Enable filetype plugins
filetype plugin indent on

set number

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = "\\"
let g:mapleader = "\\"

" Fast saving
nmap <leader>w :w!<cr>

" Yanks to global system clipboard
set clipboard^=unnamedplus

let g:skipview_files = [
\ '[EXAMPLE PLUGIN BUFFER]'
\ ]

let NERDTreeIgnore=['\.pyc$', '\~$']
" }}}

" => VIM user interface {{{
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,migrations/**,**/node_modules/**

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
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

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set switchbuf=useopen

set viewoptions=folds,cursor

" Set appropriate session options
set sessionoptions-=blank
set sessionoptions-=curdir
set sessionoptions-=sesdir
set sessionoptions-=help
set sessionoptions-=resize
set sessionoptions-=winsize
set sessionoptions-=buffer
set sessionoptions-=options
set sessionoptions-=globals
" }}}

" => Colors and Fonts {{{
" Enable syntax highlighting
syntax enable

" let moria_style = 'dark'
" let g:solarized_termcolors=256
set background=dark
set t_Co=256

" colorscheme moria
colorscheme solarized

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard
" language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac
" }}}

" => Files, backups and undo {{{
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
set undofile "so is persistent undo ...
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload
set undodir=/$HOME/.vim/undo/
set viewdir=/$HOME/.vim/view/
" }}}

" => Text, tab and indent related {{{
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=8
set softtabstop=4

" Linebreak on 500 characters
set lbr
set tw=139

" Color column for 100 characters
set colorcolumn=140

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
" }}}

" => Visual mode related {{{
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
" }}}

" => Moving around, tabs, windows and buffers {{{
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$
" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
"map <space> /
"map <c-space> ?

"noremap <silent> <C-.> :bnext<CR>
"noremap <silent> <C-,> :bprevious<CR>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
   \ if line("'\"") > 0 && line("'\"") <= line("$") |
   \   exe "normal! g`\"" |
   \ endif
" }}}

" => Status line {{{
" Always show the status line
set laststatus=2

" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

" set statusline=%f       "tail of the filename
" set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
" set statusline+=%{&ff}] "file format
" set statusline+=%h      "help file flag
" set statusline+=%m      "modified flag
" set statusline+=%r      "read only flag
" set statusline+=%y      "filetype
" set statusline+=%=      "left/right separator
" set statusline+=%{fugitive#statusline()}\
" set statusline+=%c,     "cursor column
" set statusline+=%l/%L   "cursor line/total lines
" set statusline+=\ %P    "percent through file%{fugitive#statusline()}
" }}}

" => Editing mappings {{{
" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <C-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <C-k> :m'<-2<cr>`>my`<mzgv`yo`z
vnoremap <C-h> <gv
vnoremap <C-l> >gv

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <C-j>
  vmap <D-k> <C-k>
endif

nnoremap <space> za
vnoremap <space> zf

inoremap jk <esc>
" }}}

" => Autocommands {{{
" Delete trailing white space on save, useful for Python and CoffeeScript ;)
augroup whitespace
    autocmd!
    autocmd BufWrite *.py :call DeleteTrailingWS()
    autocmd BufWrite *.coffee :call DeleteTrailingWS()
    autocmd BufWrite *.html :call DeleteTrailingWS()
    autocmd BufWrite *.js :call DeleteTrailingWS()
    autocmd BufWrite *.cpp :call DeleteTrailingWS()
    autocmd BufWrite *.hpp :call DeleteTrailingWS()
augroup END

" python file settings
augroup py_settings
    autocmd!
    autocmd BufNewFile,BufRead *.py :call SetPythonSettings()
augroup END

" js file settings
augroup js_settings
    autocmd!
    autocmd BufNewFile *.js, *.html, *.css :call SetJSSettings()
augroup END

augroup enter_exit_settings
    autocmd!
    autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
    autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<

    autocmd VimEnter * if !argc() | :call Autorun() | endif
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    autocmd BufReadPost quickfix :call OpenQuickfix()
augroup END

augroup filetype_settings
    autocmd!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS

    autocmd FileType python setl switchbuf=useopen
    autocmd FileType python setl omnifunc=jedi#completions
    autocmd FileType python setl foldmethod=expr
    autocmd FileType python let b:did_ftplugin = 1

    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    autocmd Filetype java setl omnifunc=javacomplete#Complete
    autocmd Filetype java setl completefunc=javacomplete#CompleteParamsInfo

    autocmd FileType javascript :call tern#Enable()
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css setl omnifunc=csscomplete#CompleteCSS
augroup END

" Cofee make
augroup coffee
    autocmd!
    autocmd FileType coffee :call tern#Enable()
    autocmd QuickFixCmdPost * nested :call OpenQuickfix() | redraw!
    autocmd BufWritePost *.coffee make!
    autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent
    autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
augroup END

" Json fold
augroup json
    autocmd!
    autocmd BufNewFile,BufReadPost *.json setl foldmethod=syntax
augroup END

" For all file types highlight trailing whitespaces
augroup mark_extra_whitespace
    autocmd!
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter ?* if MakeViewCheck() | match ExtraWhitespace /\s\+$/ | endif
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
augroup END

" fugitive options
augroup fugitive
    autocmd!
    autocmd BufReadPost fugitive://* set bufhidden=delete
    autocmd User fugitive if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' | nnoremap <buffer> .. :edit %:h<CR> | endif
augroup END

" vimscript folding
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" => Python with virtualenv support {{{
try
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir, venv_name = os.path.split(os.environ['VIRTUAL_ENV'])
  pyenv_base_dir = os.environ.get('PYENV_ROOT', '')
  pyenv_base_dir = os.path.join(pyenv_base_dir, 'versions') if pyenv_base_dir else ''
  for activate_dir in [pyenv_base_dir, project_base_dir]:
    activate_this = os.path.join(os.path.join(activate_dir, venv_name), 'bin/activate_this.py')
    if os.path.exists(activate_this):
      execfile(activate_this, dict(__file__=activate_this))
EOF
catch
    try
        py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir, venv_name = os.path.split(os.environ['VIRTUAL_ENV'])
  pyenv_base_dir = os.environ.get('PYENV_ROOT', '')
  pyenv_base_dir = os.path.join(pyenv_base_dir, 'versions') if pyenv_base_dir else ''
  for activate_dir in [pyenv_base_dir, project_base_dir]:
    activate_this = os.path.join(os.path.join(activate_dir, venv_name), 'bin/activate_this.py')
    if os.path.exists(activate_this):
      with open(activate_this) as f:
        code = compile(f.read(), activate_this, 'exec')
        exec(code, dict(__file__=activate_this))
EOF
    catch
    endtry
endtry
" }}}

" => Misc key mappings {{{
noremap <F8> :call OpenTreeOrUndo()<CR>
noremap <S-F8> :call CloseTreeOrUndo()<CR>
noremap <F7> :TagbarToggle<CR>
noremap <F6> <Plug>TaskList
cmap w!! w !sudo tee % >/dev/null

set <xF1>=[1;5C
set <xF2>=[1;5D

noremap <xF1> <C-Right>
noremap <xF2> <C-Left>
noremap! <xF1> <C-Right>
noremap! <xF2> <C-Left>

noremap <leader>a :Autoformat<CR>

nnoremap <silent> <C-Right> :bnext<CR>
nnoremap <silent> <C-Left> :bprev<CR>
nnoremap GG G<CR>
nnoremap G :call jedi#goto_definitions()<CR>

nnoremap <leader>s :FSHere<CR>
" }}}

" => Plugin settings {{{

" Locale settings {{{
if $LANGUAGE == 'pl_PL'
    let g:location_list_name = 'Lista lokacji'
    let g:quickfix_list_name = 'Lista quickfix'
else
    let g:location_list_name = 'Location List'
    let g:quickfix_list_name = 'Quickfix List'
endif
" }}}

" Neocomplete {{{
let g:neocomplete#enable_at_startup = 1
" Ignore case
let g:neocomplete#enable_ignore_case = 1
" Enable fuzzy completion
let g:neocomplete#enable_fuzzy_completion = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
" Auto close preview
let g:neocomplete#enable_auto_close_preview = 1
" Disable automatic completion
let g:neocomplete#disable_auto_complete = 1
" Disable autoselect
let g:neocomplete#enable_auto_select = 0

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from.*import \|^\s*from \|^\s*import \)\w*'
let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

if !exists('g:neocomplcache_omni_functions')
    let g:neocomplcache_omni_functions = {}
endif
let g:neocomplcache_omni_functions['python'] = 'jedi#completions'

if has('conceal')
    set conceallevel=2 concealcursor=i
endif
" }}}

" vim-clang {{{
" disable auto completion for vim-clang
let g:clang_auto = 0
" default 'longest' can not work with neocomplete
let g:clang_c_completeopt = 'menuone'
let g:clang_cpp_completeopt = 'menuone'
let g:clang_debug = 0
let g:clang_exec = 'clang-3.5'
let g:clang_c_options = '-std=gnu11'
let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'
" }}}

" Jedi disable completion {{{
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first=0
let g:jedi#show_call_signatures = 2
" }}}

" Syntastic {{{
let g:syntastic_python_checkers = ['flake8', 'py3kwarn']
let g:syntastic_python_flake8_args="--max-line-length=100 --max-complexity=10"
let g:syntastic_python_python_exec = '/usr/bin/python2.7'
let g:syntastic_aggregate_errors = 1
let g:syntastic_id_checkers = 1
let g:syntastic_error_symbol = "✗ "
let g:syntastic_style_error_symbol = "S✗"
let g:syntastic_warning_symbol = "⚠ "
let g:syntastic_style_warning_symbol = "S⚠"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_html_tidy_exec = 'tidy5'
let g:syntastic_html_tidy_ignore_errors=[
    \"proprietary attribute \"ng-",
    \"trimming empty <i>",
    \"trimming empty <span>",
    \"<input> proprietary attribute \"autocomplete\"",
    \"proprietary attribute \"role\"",
    \"proprietary attribute \"hidden\"",
\]
let g:syntastic_cpp_compiler = 'clang-3.5'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_cpp_config_file = '.clang'
" }}}

" Ultisnips {{{
let g:UltiSnipsExpandTrigger = "<S-Tab>"
let g:UltiSnipsJumpForwardTrigger = "<S-Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-C-Tab>"
" }}}

" Django-vim {{{
let g:django_project_directory = expand('~/Projects/'. $USER . '/')
" }}}

" TaskList {{{
let g:tlTokenList = ['FIXME', 'TODO', '@todo', 'XXX']
" }}}

" GUndo {{{
let g:gundo_width = 30
let g:gundo_preview_bottom = 1
" }}}

" Tagbar {{{
let g:tagbar_autoshowtag = 2
let g:tagbar_width = 30
" }}}

" CtrlP {{{
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:30'
" }}}

" Isort options {{{
let g:vim_isort_map = '<C-i>'
" }}}

" ?? {{{
let g:signify_vcs_list = [ 'git' ]
" }}}

" airline {{{
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#virtualenv#enabled = 0
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#branch#displayed_head_limit = 8
let g:airline#extensions#branch#format = 1
let g:airline#extensions#tagbar#enabled = 0
let g:airline_exclude_preview = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" }}}

" vim-session settings {{{
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_persist_font = 0
let g:session_persist_colors = 0
" }}}

" vim-javascript {{{
let javascript_enable_domhtmlcss = 1
let b:javascript_fold = 1
" }}}

" SimplyFold {{{
let g:SimpylFold_docstring_preview = 1
" }}}

" Tern for vim {{{
let tern_show_signature_in_pum = 1
" }}}

" texvim {{{
let g:vimtex_latexmk_options = "-pdf -e '$pdflatex=q/xelatex %O %S/' "
" }}}

" delimitmate {{{
let delimitMate_nesting_quotes = ['"','`']
let delimitMate_balance_matchpairs = 1
" }}}

" {{{ vim-vebugger

let g:vebugger_leader='<Leader>\'
let g:vebugger_view_source_cmd='e'

noremap <leader>\k :VBGkill<cr>

" }}}

" {{{ vim-autoformat



" }}}

" }}}

" => per directory session management {{{
" Check whether the current working directory contains a ".vimsessions"
" directory. It it does, well configure the vim-session plug-in to load
" its sessions from the ".vimsessions" directory.
" From: https://github.com/xolox/vim-session/issues/49
" let s:local_session_directory = xolox#misc#path#merge(getcwd(), '.vimsessions')
let s:local_session_directory = xolox#misc#path#merge($HOME . '/.vim/sessions', getcwd())
if isdirectory(s:local_session_directory)
  let g:session_directory = s:local_session_directory
endif
unlet s:local_session_directory
" }}}

" => vimgrep searching and cope displaying {{{
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR><CR>

" Open vimgrep and put the cursor in the right position
noremap <leader>g :NoAutoVimGrep //j ./**/*.*<left><left><left><left><left><left><left><left><left><left><left>

map <leader>gp :NoAutoVimGrep //j ./**/*.py<left><left><left><left><left><left><left><left><left><left><left><left>

map <leader>gj :NoAutoVimGrep //j ./**/*.js ./**/*.coffee<left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>
" Vimgreps in the current file
map <leader><space> :NoAutoVimGrep // <C-R>%OH<right><right><right><right><right><right><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"

map <silent> <leader>l :call ToggleList(g:location_list_name, 'l')<CR>
map <silent> <leader>c :call ToggleList(g:quickfix_list_name, 'c')<CR>
map <leader>n :cn<cr>
map <leader>p :cp<cr>
" }}}

" => Spell checking {{{
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=
" }}}

" => Misc {{{
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <expr><C-c>     neocomplete#start_manual_complete()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
inoremap <expr><C-Space> neocomplete#start_manual_complete()
inoremap <expr><C-@> neocomplete#start_manual_complete()
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
" }}}

" => Helper functions {{{
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call inputsave()
        let l:dir = input('Enter subpath, without enclosing / (default: ""): ', '')
        call inputrestore()
        call CmdLine("NoAutoVimGrep " . '/'. l:pattern . '/j ' . l:dir  . '/**/*.*')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bprevious
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

func! OpenNERDTree()
    exe "NERDTree"
    exe "normal 35\<C-W>|"
    try
        exe "2wincmd w"
    catch
    endtry
    let g:nerd_tree_open = 1
endfunc

func! OpenTreeOrUndo()
    echom "Toggeling nerd tree or undo"
    if !exists('g:nerd_tree_open')
        echom "Opening nerd tree"
        let g:nerd_tree_open = 1
        exe "UndotreeHide"
        exe "NERDTreeClose"
        exe "NERDTreeToggle"
        exe "normal 30\<C-W>|"
    else
        if g:nerd_tree_open == 0
            echom "Opening nerd tree"
            let g:nerd_tree_open = 1
            exe "UndotreeHide"
            exe "NERDTreeToggle"
            exe "normal 30\<C-W>|"
            exe "2wincmd w"
        else
            echo "Opening undo tree"
            let g:nerd_tree_open = 0
            exe "NERDTreeClose"
            exe "UndotreeShow"
            exe "1wincmd w"
            exe "normal 30\<C-W>|"
            exe "3wincmd w"
        endif
    endif
endfunc

func! CloseTreeOrUndo()
    if !exists('g:nerd_tree_open')
        exe "UndotreeHide"
        exe "NERDTreeClose"
    else
        if g:nerd_tree_open == 0
            exe "UndotreeHide"
        else
            let g:nerd_tree_open = 0
            exe "NERDTreeClose"
        endif
    endif
endfunc

function! GetBufferList()
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  let winnr = winnr()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      try
        exe bufnum.'wincmd w'
      catch
        echom 'No open buffer with number '.bufnum
      endtry
      exec(a:pfx.'close')
      try
        exe '2wincmd w'
      catch
      endtry
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  try
    exe '2wincmd w'
  catch
  endtry
  exec('botright '.a:pfx.'open')
  if winnr() != winnr
    try
      exe '2wincmd w'
    catch
    endtry
  endif
endfunction

function! MakeViewCheck()
    if has('quickfix') && &buftype =~ 'nofile'
        " Buffer is marked as not a file
        return 0
    endif
    if empty(glob(expand('%:p')))
        " File does not exist on disk
        return 0
    endif
    if expand('%:p:h') == '/tmp'
        " We're in a temp dir
        return 0
    endif
    if expand('%:p:h') == '/var/tmp'
        " Also in temp dir
        return 0
    endif
    if index(g:skipview_files, expand('%')) >= 0
        " File is in skip list
        return 0
    endif
    return 1
endfunction

function! ClearJediCache()
    let jedi_cache_path = expand("~/.cache/jedi")
    if isdirectory(jedi_cache_path) == 1
        exec 'silent ! rm -rf ' . jedi_cache_path . "/*"
    endif
endfunction

function! Autorun()
    " :call ClearJediCache()
    " :call OpenNERDTree()
endfunction

command! -nargs=0 BCopen call OpenQuickfix()
function! OpenQuickfix()
  let buflist = GetBufferList()
  for bufname in [g:location_list_name, g:quickfix_list_name]
    for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
      if bufname =~ g:location_list_name && len(getloclist(0)) != 0
        exe 'lclose'
        try
          exe '2wincmd w'
        catch
        endtry
        exe 'lopen'
      endif
      if bufname =~ g:quickfix_list_name
        exe 'cclose'
        exe 'botright cwindow'
      endif
    endfor
  endfor
endfunction

command! -nargs=+ NoAutoVimGrep call <SID>MyVimGrep(<f-args>)
function! <SID>MyVimGrep(...)
    exe 'noautocmd vimgrep '. join(a:000)
    exe 'cwindow'
    exe 'BCopen'
endfunction

command! -nargs=0 CreateSessionDir call MKSessionDir()
function! MKSessionDir()
  let b:sessiondir = xolox#misc#path#merge($HOME . '/.vim/sessions', getcwd())
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
    echom 'Creating dir ' . b:sessiondir . '. Setting isntead of ' . g:session_directory
  else
    echom 'Directory ' . b:sessiondir . ' exists! Setting instead of ' . g:session_directory
  endif
  let g:session_directory = b:sessiondir
endfunction

func! SetPythonSettings()
    setl tabstop=4
    setl softtabstop=4
    setl shiftwidth=4
    setl textwidth=99
    setl fileformat=unix
    setl expandtab
    setl autoindent
    setl completeopt+=longest
    setl colorcolumn=100
endfunc

func! SetJSSettings()
    setl foldmethod=syntax
    setl tabstop=2
    setl softtabstop=2
    setl shiftwidth=2
    setl textwidth=139
    setl expandtab
    setl colorcolumn=140
endfunc

function! s:my_cr_function()
  " return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

func! GenerateTags()
    if argc() > 0
        return 0
    endif
" find . -regextype posix-egrep -regex ".*/[Mm]akefile|.*/.*\.mak" -printf 'grep -o -E "[a-zA-Z0-9._/-]+(*\\.c|*\\.cc|*\\.cpp|*\\.cxx|*\\.h|*\\.hh|*\\.hpp|*\\.hxx)" %p | sed "s:^:%h/:g" | sort | uniq\n' | sh | ctags -f ~/.vim/tags -L -
endfunc

" }}}
