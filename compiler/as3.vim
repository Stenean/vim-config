if exists("current_compiler")
    finish
endif
let current_compiler = "as3"

" setlocal makeprg=flix_dev/bin/build.py\ --dev\ --all
let &l:makeprg=getcwd() . "/flix_dev/bin/build.py --dev --all"

setlocal errorformat =
    \%E%f(%l):\ col:\ %c\ Error:\ %m,
    \%E%f(%l):\ Error:\ %m,
    \%E%f:\ Error:\ %m,
    \%+C%.%#,
    \%-G%.%#
" .as(65): col: 40 Error:
" .as(65): Error:
" .as: Error:

" vim: filetype=vim
