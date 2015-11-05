set -g WAHOO_PATH $HOME/.wahoo
set -g WAHOO_CUSTOM $HOME/.dotfiles
source $WAHOO_PATH/init.fish

alias tmux "env TERM=xterm-256color tmux"

eval (python -m virtualfish compat_aliases auto_activation)
set fish_function_path $fish_function_path "/usr/local/lib/python2.7/dist-packages/powerline/bindings/fish"
powerline-setup
