" from https://github.com/lambdalisue/nose.vim/blob/master/compiler/nose.vim
"
" pip install nose
" pip install git+git://github.com/nvie/nose-machineout.git#egg=nose_machineout

if exists("current_compiler")
  finish
endif
let current_compiler = "django_nose"

if exists(":CompilerSet") != 2 " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet efm=%f:%l:\ fail:\ %m,%f:%l:\ error:\ %m
CompilerSet makeprg=$DJANGO_DIR/start.py\ test\ -v\ 0\ --with-doctest\ --with-machineout\ --testrunner=django_nose.NoseTestSuiteRunner\ $*
