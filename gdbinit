# This file contains the generic settings

set prompt gdb> 

# Stop printing arrays at a nul
set print null-stop

# Pretty Print things
set print pretty on
set print array on

#set fork-follow-mode child

handle SIGPIPE nostop noprint pass

#layout asm
#layout regs

python
from __future__ import print_function

import os
import sys

try:
    import voltron
    voltron_path = os.path.sep.join(voltron.__file__.split(os.path.sep)[:-1] + ["entry.py"])
    gdb.execute('source ' + voltron_path)
except Exception as e:
    print(e)
    print(sys.version)
    print(sys.path)
end

voltron init

# source ~/peda/peda.py
set disassembly-flavor intel

# When inspecting large portions of code the scrollbar works better than 'less'
set pagination off

# Keep a history of all the commands typed. Search is possible using ctrl-r
set history save on
set history filename ~/.gdb_history
set history size 32768
set history expansion on
