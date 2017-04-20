if exists("current_compiler")
    finish
endif
let current_compiler = "as3"

" setlocal makeprg=flix_dev/bin/build.py\ --dev\ --all
let &l:makeprg=getcwd() . "/flix_dev/bin/build.py --dev --all"

setlocal errorformat =
    \%E%f(%l):\ col:\ %c\ Error:\ %m,
    \%+C%.%#
" .as(65): col: 40 Error:

" vim: filetype=vim
