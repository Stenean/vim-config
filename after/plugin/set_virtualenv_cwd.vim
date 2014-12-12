:"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" relating to setting proper virtualenv path
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:python << EOF
import sys, os


def strip_slash(string):
    if string and string[-1] == os.path.sep:
        return string[:-1]
    else:
        return string


def append_to_sys(string):
    if string is None:
        return
    if string in sys.path:
        del sys.path[sys.path.index(string)]
    sys.path.insert(0, string)


append_to_sys(strip_slash(os.getcwd()))
append_to_sys(strip_slash(''))
EOF
