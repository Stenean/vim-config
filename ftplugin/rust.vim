compiler cargo

" order matters:
" newer rustc errors and warnings
" setl errorformat=%Eerror%m,%Z\ %#-->\ %f:%l:%c,%Wwarning%m,%Z\ %#-->\ %f:%l:%c
" setl errorformat=%Eerror%m,%Z\ \ -->\ %f:%l:%c,%Wwarning%m,%Z\ \ \ -->\ %f:%l:%c
" older rustc errors and warnings
" setl errorformat+=%f:%l:%c:\ %*[0-9]:%*[0-9]\ %trror:%m,%f:%l:%c:\ %*[0-9]:%*[0-9]\ %tarning:%m,
" cargo test error messages:
" setl errorformat+=%E----%m,%Z%m\ %f:%l
" setl errorformat+=%-C%.%#
" setl errorformat+=%-G%.%#
" setl errorformat+=%-Z%.%#
" Old errorformat (before nightly 2016/08/10)
setl errorformat=
    \%f:%l:%c:\ %t%*[^:]:\ %m,
    \%f:%l:%c:\ %*\\d:%*\\d\ %t%*[^:]:\ %m,
    \%-G%f:%l\ %s,
    \%-G%*[\ ]^,
    \%-G%*[\ ]^%*[~],
    \%-G%*[\ ]...

" Ignore general cargo progress messages
setl errorformat+=
    \%-G%\\s%#Downloading%.%#,
    \%-G%\\s%#Compiling%.%#,
    \%-G%\\s%#Finished%.%#,
    \%-G%\\s%#error:\ Could\ not\ compile\ %.%#,
    \%-G%\\s%#To\ learn\ more\\,%.%#

setl errorformat+=
    \%-G,
    \%-Gerror:\ aborting\ %.%#,
    \%-Gerror:\ Could\ not\ compile\ %.%#,
    \%Eerror:\ %m,
    \%Eerror[E%n]:\ %m,
    \%Wwarning:\ %m,
    \%Inote:\ %m,
    \%C\ %#-->\ %f:%l:%c


setl errorformat+=%-C%.%#
