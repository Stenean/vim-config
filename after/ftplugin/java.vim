setl omnifunc=javacomplete#Complete
setl completefunc=javacomplete#CompleteParamsInfo

call airline#parts#define_function('vim-gradle-status', 'gradle#statusLine')
let g:airline_section_x= airline#section#create_right(['tagbar', 'filetype', 'vim-gradle-status'])
