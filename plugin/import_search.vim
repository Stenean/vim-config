if exists( "g:loaded_importsearch" )
  finish
elseif !has( 'python' )
  echohl WarningMsg |
        \ echomsg "ImportSearch  unavailable: requires Vim compiled with " .
        \ "Python 2.x support" |
        \ echohl None
  finish
endif

execute "pyfile ".fnameescape(fnamemodify(expand("<sfile>"), ":h")."/../python/import_search.py")

command! -nargs=1 FindImport :call FindImportPython(<args>)
function! FindImportPython(name)
    let l:cmd = "find_import('" . a:name . "')"
    let l:output = pyeval(l:cmd)
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
