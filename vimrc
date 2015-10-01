""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'gmarik/Vundle.vim'

Bundle 'xolox/vim-misc'

Bundle 'vim-scripts/TaskList.vim'
Bundle 'vim-scripts/tComment'
Bundle 'vim-scripts/The-NERD-tree'

Bundle 'klen/python-mode'
Bundle 'fisadev/vim-isort'
Bundle 'scrooloose/syntastic'
Bundle 'chrisbra/csv.vim'
Bundle 'hsanson/vim-android'
Bundle 'cwood/vim-django'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'sjl/gundo.vim'
Bundle 'raimondi/delimitmate'
Bundle 'SirVer/ultisnips'
Bundle 'tpope/vim-fugitive'
Bundle 'honza/vim-snippets'
Bundle 'reinh/vim-makegreen'
Bundle 'bling/vim-airline'
Bundle 'mhinz/vim-signify'
Bundle 'majutsushi/tagbar'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'elzr/vim-json'
Bundle 'tpope/vim-dispatch'
Bundle 'mbbill/undotree'
Bundle 'edsono/vim-matchit'
Bundle 'tpope/vim-surround'
Bundle 'xolox/vim-session'
Bundle 'marijnh/tern_for_vim'
Bundle 'othree/javascript-libraries-syntax.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'Valloric/YouCompleteMe'

call vundle#end()

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,migrations/**

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
set sessionoptions-=options
set sessionoptions-=curdir

" Color column for 100 characters
set colorcolumn=100

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
set undofile "so is persistent undo ...
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload
set undodir=/$HOME/.vim/undo/
set viewdir=/$HOME/.vim/view/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
set tw=99

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

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
"Remember info about open buffers on close
set viminfo^=%

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
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
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

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

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
autocmd BufWrite *.html :call DeleteTrailingWS()
autocmd BufWrite *.js :call DeleteTrailingWS()

autocmd Filetype java setl omnifunc=javacomplete#Complete
autocmd Filetype java setl completefunc=javacomplete#CompleteParamsInfo
" autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python set switchbuf=useopen
autocmd FileType python setlocal foldmethod=expr
autocmd BufNewFile,BufReadPost *.py setl foldmethod=expr
autocmd FileType javascript setl omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript setl shiftwidth=2 expandtab
autocmd FileType coffee setl omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html setl omnifunc=htmlcomplete#CompleteTags
autocmd FileType html setl shiftwidth=2 expandtab
autocmd FileType css setl omnifunc=csscomplete#CompleteCSS
autocmd VimEnter * if !argc() | :call Autorun() | endif
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd BufWritePost,BufLeave,WinLeave,VimLeave ?* if MakeViewCheck() | mkview | endif
autocmd VimEnter ?* if MakeViewCheck() | silent loadview | endif
autocmd BufReadPost quickfix :call OpenQuickfix()

autocmd VimEnter * :call KillYcmd()

" Cofee make
autocmd QuickFixCmdPost * nested :call OpenQuickfix() | redraw!
autocmd BufWritePost *.coffee make!
autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

" Json fold
autocmd BufNewFile,BufReadPost *.json setl foldmethod=syntax

" For all file types highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter ?* if MakeViewCheck() | match ExtraWhitespace /\s\+$/ | endif
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" fugitive options
autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd User fugitive if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' | nnoremap <buffer> .. :edit %:h<CR> | endif

map <F9> :MBEToggle<cr>
map <F8> :call OpenTreeOrUndo()<CR>
map <F7> :TagbarToggle<CR>
map <F6> <Plug>TaskList
map <leader>gu :call OpenTreeOrUndo()<CR>
cmap w!! w !sudo tee % >/dev/null

set <xF1>=[1;5C
set <xF2>=[1;5D

map <xF1> <C-Right>
map <xF2> <C-Left>
map! <xF1> <C-Right>
map! <xF2> <C-Left>

nnoremap <silent> <C-Right> :bnext<CR>
nnoremap <silent> <C-Left> :bprev<CR>
nnoremap G :YcmCompleter GoTo<CR>

nnoremap <space> za
vnoremap <space> zf

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Local settings
let g:location_list_name = 'Lista lokacji'
let g:quickfix_list_name = 'Lista quickfix'

" MinBufExpl
let g:miniBufExplAutoStart=0
let g:miniBufExplBuffersNeeded=0

" Python mode
let g:pymode_trim_whitespaces = 1
let g:pymode_options = 0
let g:pymode_options_max_line_length = 99
let g:pymode_options_colorcolumn = 1
let g:pymode_indent = 1
let g:pymode_breakpoint_cmd = 'import ipdb; ipdb.set_trace() # BREAKPOINT HARDCODED'
let g:pymode_doc = 1
let g:pymode_lint = 0
let g:pymode_virtualenv = 1
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_goto_definition_bind = ''

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_use_ultisnips_completer = 1
let g:ycm_server_log_level = 'debug'

" Syntastic
let g:syntastic_python_checkers = ['flake8', 'frosted', 'python']
let g:syntastic_python_flake8_args="--max-line-length=100 --max-complexity=10"
let g:syntastic_python_python_exec = '/usr/bin/python2.7'
let g:syntastic_aggregate_errors = 1
let g:syntastic_id_checkers = 1
let g:syntastic_error_symbol = "✗ "
let g:syntastic_style_error_symbol = "S✗"
let g:syntastic_warning_symbol = "⚠ "
let g:syntastic_style_warning_symbol = "S⚠"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_html_tidy_exec = 'tidy5'

" Ultisnips
let g:UltiSnipsExpandTrigger = "<S-Tab>"
let g:UltiSnipsJumpForwardTrigger = "<S-Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-C-Tab>"

" Django-vim
let g:django_project_directory = expand('~/Projects/'. $USER . '/')

" TaskList
let g:tlTokenList = ['FIXME', 'TODO', '@todo', 'XXX']

" GUndo
let g:gundo_width = 30
let g:gundo_preview_bottom = 1

" Tagbar
let g:tagbar_autoshowtag = 2
let g:tagbar_width = 30

" CtrlP
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:30'

" Isort options
let g:vim_isort_map = '<C-i>'

" MinBufExpl settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 0
let g:miniBufExplModSelTarget = 0

" ??
let g:signify_vcs_list = [ 'git' ]

" airline
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

" vim-session settings
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'

" vim-javascript
let javascript_enable_domhtmlcss = 1
let b:javascript_fold = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => per directory session management
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Check whether the current working directory contains a ".vimsessions"
" directory. It it does, we'll configure the vim-session plug-in to load
" its sessions from the ".vimsessions" directory.
" From: https://github.com/xolox/vim-session/issues/49
" let s:local_session_directory = xolox#misc#path#merge(getcwd(), '.vimsessions')
let s:local_session_directory = xolox#misc#path#merge($HOME . '/.vim/sessions', getcwd())
if isdirectory(s:local_session_directory)
  let g:session_directory = s:local_session_directory
endif
unlet s:local_session_directory

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR><CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :NoAutoVimGrep //j ./**/*.*<left><left><left><left><left><left><left><left><left><left><left>

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
    exe "2wincmd w"
    let g:nerd_tree_open = 1
endfunc

func! RefreshMinBuff()
    exe "MBEClose"
    exe "MBEOpen"
    exe "2wincmd w"
endfunc

func! OpenTreeOrUndo()
    if !exists('g:nerd_tree_open')
        let g:nerd_tree_open = 1
        exe "UndotreeHide"
        exe "NERDTreeClose"
        exe "NERDTreeToggle"
        exe "normal 35\<C-W>|"
    endif

    if g:nerd_tree_open == 0
        let g:nerd_tree_open = 1
        exe "UndotreeHide"
        exe "NERDTreeToggle"
        exe "normal 35\<C-W>|"
        exe "2wincmd w"
    else
        let g:nerd_tree_open = 0
        exe "NERDTreeClose"
        exe "UndotreeShow"
        exe "1wincmd w"
        exe "normal 35\<C-W>|"
        exe "3wincmd w"
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
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exe bufnum.'wincmd w'
      exec(a:pfx.'close')
      exe '2wincmd w'
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exe '2wincmd w'
  exec('botright '.a:pfx.'open')
  if winnr() != winnr
    exe '2wincmd w'
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

function! ClearJediCache()
    let jedi_cache_path = expand("~/.cache/jedi")
    if isdirectory(jedi_cache_path) == 1
        exec 'silent ! rm -rf ' . jedi_cache_path . "/*"
    endif
endfunction

function! Autorun()
    ":call ClearJediCache()
    :call OpenNERDTree()
endfunction

command! -nargs=0 BCopen call OpenQuickfix()
function! OpenQuickfix()
  let buflist = GetBufferList()
  for bufname in [g:location_list_name, g:quickfix_list_name]
    for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
      if bufname =~ g:location_list_name && len(getloclist(0)) != 0
        exe 'lclose'
        exe '2wincmd w'
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
