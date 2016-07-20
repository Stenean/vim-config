# vim: set fdm=marker
# User configuration
export TERM="xterm-256color"
export SHELL="/bin/zsh"
export PATH="/home/$USER/.vim/bin/:/home/$USER/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"
# export MANPATH="/usr/local/man:$MANPATH"
if [ -d "/usr/lib/jvm/java-8-oracle" ]; then
    export JAVA_HOME=/usr/lib/jvm/java-8-oracle
fi

export EDITOR='vim'

if [ -x "$(command -v git)" ] && [ "diffconflicts" != "$(git config --global merge.tool)" ]; then
# Git config {{{
    git config --global merge.tool diffconflicts
    git config --global mergetool.diffconflicts.cmd 'diffconflicts vim $BASE $LOCAL $REMOTE $MERGED'
    git config --global mergetool.diffconflicts.trustExitCode true
    git config --global mergetool.diffconflicts.keepBackup false
# }}}
fi

export PROJECT_HOME="$HOME/Projects"

if [ ! -f ~/.zgen/zgen.zsh ]; then
  pushd ~
  git clone https://github.com/tarjoilija/zgen.git .zgen
  popd
fi
source ~/.zgen/zgen.zsh

# Path to your oh-my-zsh installation.
# export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

DEFAULT_USER="kuba"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git, command-not-found, docker, jsontools, python, suprevisor, virtualenvwrapper)

if ! zgen saved; then
# Zgen config {{{
    echo "Creating a zgen save"

    zgen oh-my-zsh

    zgen load RobSis/zsh-completion-generator

    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/command-not-found
    zgen oh-my-zsh plugins/docker
    zgen oh-my-zsh plugins/jsontools
    zgen oh-my-zsh plugins/python
    zgen oh-my-zsh plugins/supervisor
    zgen oh-my-zsh plugins/virtualenvwrapper
    zgen oh-my-zsh plugins/bgnotify
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/tmux
    zgen oh-my-zsh plugins/tmux-cssh
    zgen oh-my-zsh plugins/compleat
    zgen oh-my-zsh plugins/encode64
    zgen oh-my-zsh plugins/httpie
    zgen oh-my-zsh plugins/history
    zgen oh-my-zsh plugins/pip
    zgen oh-my-zsh plugins/urltools
    zgen oh-my-zsh plugins/aws
    zgen oh-my-zsh plugins/colored-man-pages
    zgen oh-my-zsh plugins/colorize
    zgen oh-my-zsh plugins/cp
    zgen oh-my-zsh plugins/catimg
    zgen oh-my-zsh plugins/nmap

    zgen load arzzen/calc.plugin.zsh
    zgen load zsh-users/zsh-syntax-highlighting

    # autosuggestions should be loaded last
    zgen load tarruda/zsh-autosuggestions
    zgen save
# }}}
fi

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"

# You may need to manually set your language environment
export LANG=pl_PL.UTF-8

# Aliases {{{

alias ll="ls -la"
alias clearpyc="find . -name '*.pyc' -delete"
alias tmux="TERM='xterm-256color' tmux"

# }}}

xmodmap -e "keycode 166=Prior"
xmodmap -e "keycode 167=Next"

# Python and pyenv setup {{{

. /usr/local/lib/python2.7/dist-packages/powerline/bindings/zsh/powerline.zsh

export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv virtualenvwrapper

# }}}

## Functions {{{

function gdb_window {
# {{{
    if [ -n "$(env | grep 'TMUX=')" ]; then
        tmux splitw -p 25
        tmux selectp -t :.0
        tmux splitw -h -p 75
        tmux selectp -t :.0
        tmux splitw -p 88
        tmux splitw -p 73
        tmux selectp -t :.3
        tmux splitw -p 30
        # tmux send-keys -t :.0 C-z 'voltron view b' Enter
        tmux send-keys -t :.1 C-z 'voltron view bt' Enter
        tmux send-keys -t :.2 C-z 'voltron view r -i' Enter
        tmux send-keys -t :.3 C-z 'voltron view s' Enter
        tmux send-keys -t :.5 C-z 'voltron view d' Enter
        tmux send-keys -t :.4 C-z "cd \"$(pwd)\"; $*" Enter
    fi
}
# }}}

function ggdb {
# {{{
    cd $(pwd);
    WAIT_SECS=2;
    while 1; do
        GDB_PORT=$[${RANDOM} % 22000 + 10000]
        if [ -z "$(netstat -a | grep $GDB_PORT)" ]; then
            break;
        fi;
    done;
    GDBSERV_OUT="./gdb.out.$GDB_PORT.txt";
    {gdbserver --once localhost:$GDB_PORT $1 1>$GDBSERV_OUT &};
    echo "[1] Waiting ${WAIT_SECS}s for gdb server start"; sleep $WAIT_SECS;
    gdb -ex "target remote localhost:$GDB_PORT" $1;
    rm $GDBSERV_OUT;
}
# }}}

# }}}

alias sudo='sudo '

if [ -e "$HOME/.zshrc_local" ]; then
    source ~/.zshrc_local
fi
