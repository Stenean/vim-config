" Vim compiler file
" Compiler:		Python     
" Maintainer:   Christoph Herzog <ccf.herzog@gmx.net>
" Last Change:  2002 Nov 9

if exists("current_compiler")
  finish
endif
let current_compiler = "django"

let s:cpo_save = &cpo
set cpo-=C

" setlocal makeprg=$DJANGO_DIR/start.py\ test\ -v\ 0\ $*
setlocal makeprg=$DJANGO_DIR/manage.py\ test\ -v\ 0\ $*

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
" setlocal efm=
"         \%-G\.%\\+,
"         \%C\ %.%#,
"         \%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,
"         \%Z%[%^\ ]%\\@=%m,
let &cpo = s:cpo_save
unlet s:cpo_save

"vim: ft=vim
