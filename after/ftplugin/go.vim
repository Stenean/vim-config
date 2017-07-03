setl tabstop=8
setl softtabstop=8
setl shiftwidth=8

augroup go_make_test
    " this one is which you're most likely to use?
    autocmd!
    autocmd BufReadPost,BufNewFile *.go setlocal makeprg=GOOS\=linux\ go\ build
    autocmd BufReadPost,BufNewFile *_test.go setlocal makeprg=go\ test
augroup end
