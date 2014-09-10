filetype off
call pathogen#infect()
call pathogen#helptags()
syntax on
filetype on
filetype plugin indent on

set t_Co=256
set backup
set backupdir=~/.vim/backup
set number 
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set softtabstop=4
set autoindent
set foldmethod=indent
set foldlevel=99
set completeopt=menuone,longest,preview
set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%{fugitive#statusline()}
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file%{fugitive#statusline()}
set listchars=tab:»\ ,eol:¬
set autochdir
set clipboard=unnamedplus

let g:session_directory="~/.vimsession/"
let g:session_autoload='yes'
let g:session_autosave='yes'
let g:session_autosave_periodic=5
let g:miniBufExplAutoStart=1
let g:miniBufExplBuffersNeeded=1
let g:pymode_warnings = 0
let g:pymode_breakpoint_cmd = 'import wdb; wdb.set_trace()'
let g:pymode_lint_message = 1
let g:pymode_trim_whitespaces = 1
let g:pymode_options = 1
let g:pymode_indent = 1
let g:pymode_doc = 1
let g:pymode_lint_checkers = ['pyflakes','pylint','pep8','mccabe','pep257']
let g:pymode_lint_write = 1
let g:pymode_virtualenv = 0
let g:pymode_rope_goto_definition_bind = ''
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_rope_completion = 0
set textwidth=99
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:syntastic_python_checkers = []
let g:ycm_key_list_select_completion = ['<Enter>', '<Down>']
let g:UltiSnipsExpandTrigger="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-s-tab>"
" let moria_style = 'dark'
" colorscheme moria
syntax enable
set background=light
colo solarized

autocmd Filetype java setlocal omnifunc=javacomplete#Complete
autocmd Filetype java setlocal completefunc=javacomplete#CompleteParamsInfo
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

map <F9> :MBEToggle<cr>
map <F8> :NERDTreeToggle<CR>
map <F7> <Plug>TaskList
map <leader>g :GundoToggle<CR>
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

nmap <leader>a <Esc>:Ack!
nmap <leader>l :set list!<CR>

noremap <C-Down> <C-W>j
noremap <C-Up> <C-W>k
noremap <C-Left> <C-W>h
noremap <C-Right> <C-W>l
noremap <C-TAB> :MBEbf<CR>
noremap <C-S-TAB> :MBEbb<CR>
nnoremap y "+y
vnoremap y "+y
nnoremap G :YcmCompleter GoToDefinitionElseDeclaration<CR>

" syntax highlighting groups
hi Comment      ctermfg=12
hi Constant     ctermfg=6
hi Identifier   ctermfg=4
hi Statement    ctermfg=2
hi PreProc      ctermfg=1
hi Type         ctermfg=3
hi Special      ctermfg=5
hi Underlined   ctermfg=7
hi Ignore       ctermfg=9
hi Error        ctermfg=11
hi Todo         ctermfg=1

if has ('gui_running')
    highlight Pmenu guibg=#cccccc gui=bold
endif

