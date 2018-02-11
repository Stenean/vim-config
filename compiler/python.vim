" Vim compiler file
" Compiler:		Python     
" Maintainer:   Christoph Herzog <ccf.herzog@gmx.net>
" Last Change:  2002 Nov 9

if exists("current_compiler")
  finish
endif

if has('python')
  command! -nargs=1 Python python <args>
  let current_compiler = "python"
elseif has('python3')
  command! -nargs=1 Python python3 <args>
  let current_compiler = "python3"
else
  echo "Error: Requires Vim compiled with +python or +python3"
  finish
endif

let s:cpo_save = &cpo
set cpo-=C

Python << EOF
import vim
import os

if 'DJANGO_DIR' in os.environ:
    cmd = "$DJANGO_DIR/manage.py test -v 0 $*"
else:
    cmd = "python -m unittest -v $*"

vim.command("let &l:makeprg='%s'" % cmd)

EOF
"
" setlocal makeprg=python\ %

let &l:shellpipe = "2>&1| tee "

"the last line: \%-G%.%# is meant to suppress some
"late error messages that I found could occur e.g.
"with wxPython and that prevent one from using :clast
"to go to the relevant file and line of the traceback.
setlocal errorformat=
	\%A\ \ File\ \"%f\"\\\,\ line\ %l\\\,%m,
	\%C\ \ \ \ %.%#,
	\%+Z%.%#Error\:\ %.%#,
	\%A\ \ File\ \"%f\"\\\,\ line\ %l,
	\%+C\ \ %.%#,
	\%-C%p^,
	\%Z%m,
	\%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save

"vim: ft=vim
