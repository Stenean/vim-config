" vim: set ts=2 sw=2 sts=2 et fdm=marker:
" => General {{{
" Sets how many lines of history VIM has to remember
set history=10000
" set term=xterm-256color
set term=screen-256color
set t_ut=
set t_ts=]2;
set t_fs=\\

set title
set titleold=shell

set nocompatible
filetype off

if $PYTHON_VERSION
    if $PYTHON_VERSION == 3
        python3 import sys
    else
        python import sys
    endif
endif

if has('python')
    let g:ycm_server_python_interpreter = system('python -c "import sys; sys.stdout.write(sys.executable)"')
elseif has('python3')
    let g:ycm_server_python_interpreter = system('python3 -c "import sys; sys.stdout.write(sys.executable)"')
endif

set rtp+=~/.vim/bundle/Vundle.vim
" {{{ Plugin definitions
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'

Plugin 'vim-scripts/TaskList.vim'
Plugin 'vim-scripts/tComment'
Plugin 'vim-scripts/The-NERD-tree'

Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-sensible'

Plugin 'Shougo/vimproc.vim'

Plugin 'artur-shaik/vim-javacomplete2'
Plugin 'Chiel92/vim-autoformat'
Plugin 'chrisbra/csv.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'dag/vim2hs'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'eagletmt/ghcmod-vim'
Plugin 'eagletmt/neco-ghc'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'elzr/vim-json'
Plugin 'fatih/vim-go'
Plugin 'fisadev/vim-isort'
Plugin 'godlygeek/tabular'
Plugin 'honza/vim-snippets'
Plugin 'hsanson/vim-android'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'idanarye/vim-vebugger'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'Konfekt/FastFold'
Plugin 'leafgarland/typescript-vim'
Plugin 'lervag/vimtex'
Plugin 'majutsushi/tagbar'
Plugin 'MarcWeber/vim-addon-local-vimrc'
Plugin 'mbbill/undotree'
Plugin 'mhinz/vim-signify'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
Plugin 'pbrisbin/vim-syntax-shakespeare'
Plugin 'plasticboy/vim-markdown'
Plugin 'python-rope/ropevim'
Plugin 'raimondi/delimitmate'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'sjl/gundo.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'

call vundle#end()
" }}}

let python_highlight_all=1

syntax on

" Enable filetype plugins
filetype plugin indent on

set number

" Set to auto read when a file is changed from the outside
set autoread

set nowrap

" More natural split opening
set splitbelow
set splitright

" Fold optimisations
syntax sync minlines=256
set synmaxcol=300
set re=1

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = "\\"
let g:mapleader = "\\"

" Fast saving
nmap <leader>w :w!<cr>

" Yanks to global system clipboard
set clipboard^=unnamed
set clipboard^=unnamedplus

let g:skipview_files = [
\ '[EXAMPLE PLUGIN BUFFER]'
\ ]

let NERDTreeIgnore=['\.pyc$', '\~$']

let g:last_nerdtree = 0
let g:last_quickfix = 0
let g:last_buf_file = ''
let g:first_refresh = 0
" }}}

" => Python with virtualenv support {{{

if has('python')
    let python_cmd='python'
else
    let python_cmd='python3'
endif
" let python_str=python_cmd.' -c "import sys; sys.stdout.write(\":\".join(sys.path)")'
" let python_sys=system(python_str)

let python_eof=python_cmd.' << EOF'
exec python_eof
import os
import sys
import vim


if 'VIRTUAL_ENV' in os.environ:
  project_base_dir, venv_name = os.path.split(os.environ['VIRTUAL_ENV'])
  pyenv_base_dir = os.environ.get('PYENV_ROOT', '')
  pyenv_base_dir = os.path.join(pyenv_base_dir, 'versions') if pyenv_base_dir else ''
  for activate_dir in [pyenv_base_dir, project_base_dir]:
    activate_this = os.path.join(os.path.join(activate_dir, venv_name), 'bin/activate_this.py')
    if os.path.exists(activate_this):
      if sys.version_info.major == 2:
        execfile(activate_this, dict(__file__=activate_this))
      else:
        with open(activate_this) as f:
          code = compile(f.read(), activate_this, 'exec')
          exec(code, dict(__file__=activate_this))

# for path in reversed(vim.eval('python_sys').split(":")):
#     path = path.strip()
#     if path == "" or path in sys.path:
#         continue
#     sys.path.insert(0, path)
#
# for path in sys.path[:]:
#     if '/usr/lib/python' in path or '/usr/local/lib/python' in path:
#         sys.path.remove(path)
EOF
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

set viewoptions=cursor,slash,unix

" Set appropriate session options
set sessionoptions-=blank
" set sessionoptions-=buffers
set sessionoptions-=folds
set sessionoptions-=globals
set sessionoptions-=options
set sessionoptions-=resize
set sessionoptions-=sesdir
set sessionoptions-=winsize
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
    let $PATH = '/Users/'.$USER.'/.pyenv/shims:'.$PATH
    :exec 'python import os; os.environ["PATH"] = "' . $PATH . '"'
    set guioptions-=T
    set guioptions+=e
    set guitablabel=%M\ %t
    set guifont=Menlo\ Regular\ for\ Powerline:h12
endif

" Set utf8 as standard encoding and en_US as the standard
" language
let $LANG='en'
set langmenu=en
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

let s:vim_path = $HOME . '/.vim/'
if strlen(finddir('undo', s:vim_path)) == 0
  call system('mkdir -p ' . s:vim_path . 'undo')
endif
if strlen(finddir('view', s:vim_path)) == 0
  call system('mkdir -p ' . s:vim_path . 'view')
endif

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
" }}}

" => Status line {{{
" Always show the status line
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

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

" => Key mappings {{{
" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <C-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <C-k> :m'<-2<cr>`>my`<mzgv`yo`z
vnoremap <C-h> <gv
vnoremap <C-l> >gv

noremap <xF1> <A-Right>
noremap <xF2> <A-Left>
noremap! <xF1> <A-Right>
noremap! <xF2> <A-Left>

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <C-j>
  vmap <D-k> <C-k>
  set <xF1>=[1;3C
  set <xF2>=[1;3D
  nnoremap <silent> <xF1> :bnext<CR>
  nnoremap <silent> <xF2> :bprev<CR>
elseif system("grep -i 'windows' /proc/sys/kernel/osrelease") != ''
  set <xF1>=[1;2C
  set <xF2>=[1;2D
  nnoremap <silent> <A-Right> :bnext<CR>
  nnoremap <silent> <A-Left> :bprev<CR>
else
  set <xF1>=[1;3C
  set <xF2>=[1;3D
  nnoremap <silent> <A-Right> :bnext<CR>
  nnoremap <silent> <A-Left> :bprev<CR>
endif

nnoremap <space> za
vnoremap <space> zf

inoremap jk <esc>

" => custom plugin mapping {{{

noremap <F8> :call OpenTreeOrUndo()<CR>
noremap <S-F8> :call CloseTreeOrUndo()<CR>
noremap <F7> :TagbarToggle<CR>
noremap <F6> <Plug>TaskList
cmap w!! w !sudo tee % >/dev/null
cnoreabbrev h <C-r>=(&columns >= 180 && getcmdtype() ==# ':' && getcmdpos() == 1 ? 'vertical botright help' : 'h')<CR>

nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
imap <F4> <Plug>(JavaComplete-Imports-AddSmart)

nmap <F5> <Plug>(JavaComplete-Imports-Add)
imap <F5> <Plug>(JavaComplete-Imports-Add)

nnoremap ] :YcmCompleter GoToDefinition<CR>

noremap <leader>a :Autoformat<CR>

nnoremap <leader>s :FSHere<CR>

" }}}

" => vimgrep searching and cope displaying {{{
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR><CR>

" Open vimgrep and put the cursor in the right position
noremap <leader>g :NoAutoVimGrep //j ./**/*.*<right><right><right><right><right><right><right><right><right><right><right><right><right><right><right>

map <leader>gp :NoAutoVimGrep //j ./**/*.py<right><right><right><right><right><right><right><right><right><right><right><right><right><right><right>

map <leader>gg :NoAutoVimGrep //j ./**/*.go<right><right><right><right><right><right><right><right><right><right><right><right><right><right><right>

map <leader>gj :NoAutoVimGrep //j ./**/*.js ./**/*.coffee ./**/*.ts<right><right><right><right><right><right><right><right><right><right><right><right><right><right><right>

map <leader>ga :NoAutoVimGrep //j ./**/*.as<right><right><right><right><right><right><right><right><right><right><right><right><right><right><right>
" Vimgreps in the current file
map <leader><space> :NoAutoVimGrep // <C-R>%<right><right><right><right><right><right><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" simple todo fix fixme searcher
noremap <leader>t :NoAutoVimGrep /TODO:\\|FIX:\\|FIXME:/j ./**/*.*<CR>

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

" }}}

" => Autocommands {{{

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
augroup whitespace
    autocmd!
    autocmd BufWrite *.py :call DeleteTrailingWS()
    autocmd BufWrite *.coffee :call DeleteTrailingWS()
    autocmd BufWrite *.ts :call DeleteTrailingWS()
    autocmd BufWrite *.js :call DeleteTrailingWS()
    autocmd BufWrite *.html :call DeleteTrailingWS()
    autocmd BufWrite *.cpp :call DeleteTrailingWS()
    autocmd BufWrite *.hpp :call DeleteTrailingWS()
    autocmd BufWrite *.as :call DeleteTrailingWS()
    autocmd BufWrite *.mxml :call DeleteTrailingWS()
    autocmd BufWrite *.go :call DeleteTrailingWS()
augroup END

augroup android_settings
    autocmd!
    autocmd BufWrite build.gradle call gradle#sync()
"    autocmd BufNewFile,BufRead,BufEnter *.java let g:JavaComplete_SourcesPath=$SRCPATH
augroup END

augroup enter_exit_settings
    autocmd!
    autocmd BufEnter * :syntax sync fromstart

    autocmd VimEnter * if !argc() | :call Autorun() | endif
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | else | call SyncTree()  | endif

    autocmd QuickFixCmdPost * nested :call OpenQuickfix()
    autocmd BufWinEnter * :call JumpToMainAfterQuickfix()
    autocmd BufEnter * :call JumpToMainAfterQuickfix()
    autocmd WinLeave * if &buftype == 'quickfix' | let g:last_quickfix = 1 | endif
    autocmd BufEnter * if &ft == 'nerdtree' | let g:last_nerdtree = 1 | endif
    autocmd BufLeave * :call SaveBufFileName()
augroup END

" Rainbow Parentheses
augroup rainbow
  autocmd!
  autocmd FileType * call rainbow_parentheses#activate()
augroup END

" Cofee make
augroup coffee
    autocmd!
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

" on resize
augroup onresize
    autocmd!
    autocmd VimResized * :call OnResize()
augroup END

augroup filetypedetect
  " Mail
  autocmd BufRead,BufNewFile *mutt-* setfiletype mail
augroup END

" Return to last edit position when opening files (You want this!)
augroup resCur
    autocmd!
    autocmd BufLeave * exe "normal! m\""
    if has("folding")
        autocmd BufWinEnter * if ResCur() | call UnfoldCur() | endif
    else
        autocmd BufWinEnter * call ResCur()
    endif
augroup END

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
let g:neocomplete#enable_at_startup = 0
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

" if has('conceal')
"     set conceallevel=2 concealcursor=i
" endif
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
let g:syntastic_python_checkers = ['flake8', 'pylint', 'py3kwarn']
let g:syntastic_python_flake8_args="--max-line-length=100 --max-complexity=10"
let g:syntastic_python_python_exec = '/usr/bin/python2.7'
let g:syntastic_typescript_checkers = ['tslint']
let g:syntastic_auto_loc_list = 0
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
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_rust_rustc_args = '-Zno-trans'
let g:syntastic_rust_rustc_exe = 'cargo rustc'
let g:syntastic_rust_rustc_fname = ''
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck', 'go']
" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

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
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#branch#format = 1
let g:airline#extensions#tagbar#enabled = 0
let g:airline_exclude_preview = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if &columns > 180
  let g:airline_section_c = '%<%f%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__# %{airline#util#wrap(go#statusline#Show(),0)}'
endif
" }}}

" vim-session settings {{{

let g:session_persist_globals = ['g:nerd_tree_open']
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

" {{{ ctags

let &tags="./.tags,.tags,~/.tags,".&tags

let g:easytags_syntax_keyword = 'always'
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_include_members = 1
let g:easytags_resolve_links = 1
let g:easytags_nohl = 1
autocmd BufEnter * let b:easytags_nohl = 1

" }}}

" {{{ YouCompleteMe

let g:ycm_key_invoke_completion = '<C-C>'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_key_list_select_completion = ['<Down>', '<Tab>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_key_list_stop_completion = ['<CR>']
let g:ycm_use_ultisnips_completer = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_extra_conf_globlist = ['~/Projekty/*', '~/Projects/*']
let g:ycm_server_python_interpreter = 'python'
let g:ycm_python_binary_path = 'python'
let g:ycm_rust_src_path = '/opt/rust/rustc-1.12.0/src'

" }}}

" {{{ Solarized

let g:solarized_visibility="low"    "default value is normal

" }}}

" {{{ rust

let g:rust_fold = 1
let g:ftplugin_rust_source_path = '/opt/rust/rustc-1.12.0/src'
let g:ycm_rust_src_path = '/opt/rust/rustc-1.12.0/src'

" }}}

" {{{ vim-go

let g:go_list_type = "quickfix"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" }}}

" {{{ rainbow parentheses

" let g:rainbow#pairs = [['(', ')'], ['[', ']']]
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let g:rainbow#forbidden = ['php']

" }}}

" {{{ php.vim
let php_parent_error_open=1
let php_htmlInStrings=1
let php_folding=1
let php_noShortTags=1
" }}}

" vim-markdown {{{

let g:vim_markdown_fenced_languages = ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'http=json']

" }}}

" vim-addon-local-vimrc {{{
" }}}

if !exists('g:local_vimrc')
  let g:local_vimrc = {}
endif
if !exists("g:local_vimrc['names']")
  let g:local_vimrc['names'] = []
endif
let g:local_vimrc['names'] += ['.local-vimrc']

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

" Recommended key-mappings.
" <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
" }}}

" => Helper functions {{{

function! ResCur()
  if line("'\"") > 1 && line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

if has("folding")
    function! UnfoldCur()
        if !&foldenable
            return
        endif
        let cl = line(".")
        if cl <= 1
            return
        endif
        let cf  = foldlevel(cl)
        let uf  = foldlevel(cl - 1)
        let min = (cf > uf ? uf : cf)
        if min
            execute "normal!" min . "zo"
            return 1
        endif
    endfunction
endif

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
    exe "normal 30\<C-W>|"
    call GoToMainWindow()
    let g:nerd_tree_open = 1
endfunc

func! OpenTreeOrUndo()
    if !exists('g:nerd_tree_open')
        let g:nerd_tree_open = 1
        exe "UndotreeHide"
        exe "NERDTreeClose"
        exe "NERDTreeToggle"
    else
        if g:nerd_tree_open == 0
            let g:nerd_tree_open = 1
            exe "UndotreeHide"
            exe "NERDTreeToggle"
        else
            let g:nerd_tree_open = 0
            exe "NERDTreeClose"
            exe "UndotreeShow"
            exe "UndotreeFocus"
        endif
    endif
    exe "normal 30\<C-W>|"
    call GoToMainWindow()
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
  call GoToMainWindow()
endfunc

function! GetBufferList()
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction

function! GoToMainWindow()
" 1resize 56|vert 1resize 30|2resize 56|vert 2resize 208|
  if version >= 800
    if !exists('g:window_id')
      let g:window_id = 1000
    endif
    let s:curr_pos = win_id2win(g:window_id)
    if s:curr_pos == 0
      for sizes in map(filter(split(winrestcmd(), '|'), 'v:val =~ "vert"'), "split(matchstr(v:val, '\\dresize \\d\\+'), 'resize ')")
        if str2nr(sizes[1]) > 45
          let g:window_id = win_getid(sizes[0])
        endif
      endfor
    endif
    exe win_id2win(g:window_id).'wincmd w'
  else
    for sizes in map(filter(split(winrestcmd(), '|'), 'v:val =~ "vert"'), "split(matchstr(v:val, '\\dresize \\d\\+'), 'resize ')")
      if str2nr(sizes[1]) > 45
        exe sizes[0].'wincmd w'
        return
      endif
    endfor
  endif
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      call GoToMainWindow()
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  if a:pfx == 'c'
    let g:last_quickfix = 1
  endif
  call GoToMainWindow()
  exec('botright '.a:pfx.'open')
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
    :call SyncTree()
endfunction

command! -nargs=0 BCopen call OpenQuickfix()
function! OpenQuickfix()
  let buflist = GetBufferList()
  for bufname in [g:location_list_name, g:quickfix_list_name]
    for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
      if bufname =~ g:location_list_name && len(getloclist(0)) != 0
        exe 'lclose'
        call GoToMainWindow()
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
    exe 'botright cwindow'
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

function! s:my_cr_function()
  " return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  echom '[+] Pumvisible ' . pumvisible()
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

function! KillYcmd()
    let pid_pairs = {}
    let existing_ycmds = split(system('ps xo ppid,pid,cmd | grep ycmd | grep -v grep'), '\n')
    for pair in map(existing_ycmds, 'split(matchstr(v:val, "^\\s*\\d\\+\\s*\\d\\+"), "\\s\\+")')
      let pid_pairs[str2nr(pair[1])] = str2nr(pair[0])
    endfor
    for [pid, parent] in items(pid_pairs)
      let parent_cmd = split(system('ps axo pid,cmd | grep -v grep |  grep ' . parent), '\n')[0]
      if parent_cmd !~ 'vim'
        echom 'Killing ' . pid . ', becouse parent "' . parent_cmd . '" is not vim'
        let l:kill_cmd = 'silent ! kill -9 ' . pid
        echom l:kill_cmd
        exec l:kill_cmd
      endif
    endfor
endfunction

function! OnResize()
  if &columns > 180
    let g:airline_section_c = '%<%f%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__# %{airline#util#wrap(go#statusline#Show(),0)}'
  else
    let g:airline_section_c = '%<%f%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
  endif
  exec 'AirlineRefresh'
  cnoreabbrev h <C-r>=(&columns >= 180 && getcmdtype() ==# ':' && getcmdpos() == 1 ? 'vertical botright help' : 'h')<CR>
endfunction

" returns true if is NERDTree open/active
function! IsNTOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" returns true if current buffer is visible in current window
function! InNT()
  return exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) == winnr()
endfunction

" calls NERDTreeFind iff NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
function! SyncTree()
  if IsNTOpen() && g:first_refresh
    let l:same_buff = SameBuffer()
  else
    let l:same_buff = 0
  endif

  if &modifiable && IsNTOpen() && strlen(expand('%')) > 0 && !&diff && !InNT() && &ft != 'gitcommit' && !l:same_buff
    let s:last_win = win_getid()
    if !win_id2win(s:last_win)
      exe 'NERDTreeCWD'
      call GoToMainWindow()
      exe 'NERDTreeFind'
      normal R
      call GoToMainWindow()
    else
      exe 'NERDTreeCWD'
      exe win_id2win(s:last_win) . "wincmd w"
      exe 'NERDTreeFind'
      normal R
      exe win_id2win(s:last_win) . "wincmd w"
    endif
    :call SaveBufFileName()
    let g:first_refresh = 1
  endif
endfunction

" automatically jump to main window if quickfix exit causes move to nerdtree - only trigger on BufEnter
function! JumpToMainAfterQuickfix()
  if !exists('g:last_quickfix')
    let g:last_quickfix = 0
  endif

  if g:last_quickfix == 1 && bufname('%') != ''
    let g:last_quickfix = 0
    if &buftype == 'nofile'
      call GoToMainWindow()
    endif
  endif
endfunction

" remember buffer filename on enter
function! SaveBufFileName()
  if &modifiable && strlen(expand('%:p')) > 0
    let g:last_buf_file = resolve(expand('%:p'))
  endif
endfunction

" check if we switched editable buffers
function! SameBuffer()
  if g:last_buf_file == resolve(expand('%:p')) && g:last_buf_file != ""
    return 1
  else
    return 0
  endif
endfunction

function! RainbowEnable()
  exe 'RainbowParentheses'
  syntax on
endfunction

" }}}
