if exists( "g:loaded_importsearch" )
  finish
elseif !has( 'python' ) && !has( 'python3' )
  echohl WarningMsg |
        \ echomsg "ImportSearch  unavailable: requires Vim compiled with " .
        \ "Python 2.x or 3.x support" |
        \ echohl None
  finish
endif

if has('python')
    execute "pyfile ".fnameescape(fnamemodify(expand("<sfile>"), ":h")."/../python/import_search.py")
else
    execute "py3file ".fnameescape(fnamemodify(expand("<sfile>"), ":h")."/../python/import_search.py")
endif

command! -nargs=1 FindImport :call FindImportPython(<args>)
function! FindImportPython(name)
    let l:cmd = "find_import('" . a:name . "')"
    if has('python')
        let l:output = pyeval(l:cmd)
    else
        let l:output = py3eval(l:cmd)
    call inputsave()
    let l:nothing = input('Found modules: '.string(output))
    call inputrestore()
    return output
endfunction

vnoremap <leader>i :<C-U>
  \let old_reg = getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy
  \:FindImport @"<CR>
  \:call setreg('"', old_reg, old_regtype)<CR>
