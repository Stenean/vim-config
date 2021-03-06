# vim: set fdm=marker:
# User configuration
# export TERM="xterm-256color"
export SHELL="/usr/local/bin/zsh"
export PATH="$HOME/.vim/bin:$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/games:/usr/games:$PATH"

export PROJECT_HOME="$HOME/Projects"
export WORKON_HOME="$HOME/.virtualenvs"
DISABLE_UNTRACKED_FILES_DIRTY="true"


gpg_agent_command="gpg-agent --homedir $HOME/.gnupg --daemon"
gpg_agent_not_good=$(ps -Aopid,command | sed -e "\:$gpg_agent_command:!d" -e '/sed/d' -e 's/^[ \t]*//g' | cut -d' ' -f1)
gpg_agent_pid=$(ps -Aopid,command | sed -e '/gpg-agent/!d' -e '/sed/d' -e 's/^[ \t]*//g' | cut -d' ' -f1)
if [ -n "$gpg_agent_pid" -a -n "$gpg_agent_not_good" ]; then
    kill -9 $gpg_agent_pid
fi
eval $(eval $gpg_agent_command 2>/dev/null)

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

function tmux-session {
# {{{
    if (( $# == 0)); then
        tmux new-session -t default || tmux new-session -s default
    else
        tmux $@
    fi
}
# }}}

function preexec() {
# {{{
    timer=${timer:-$SECONDS}
}
# }}}

function precmd() {
# {{{
    if [ $timer ]; then
        export timer_show=$(($SECONDS - $timer))
        unset timer
    fi
}
# }}}

# Syntax for setting up deve env directories:
# dev_env_directories=(
#     '<path to open>|<program to start>|<virtualenv to activate>'
# )
set -a dev_env_directories
function devEnv() {
# {{{
    if [ $#dev_env_directories -eq 0 ]; then
        >&2 echo "[!] dev_env_directories not set!"
        return
    fi
    if [ -z "$(env | grep 'TMUX=')" ]; then
        >&2 echo "Tmux not running!"
        return
    fi
    last=$(tmux list-windows | cut -d: -f1 | tail -n1)
    active=$(tmux list-windows | grep active | cut -d: -f1 | tail -n1)
    delta=$(echo "$last - $active" | bc)

    # echo "Last win num: $last, active window: $active, delta: $delta, num of commands: $#directories"
    for i in $(seq $#dev_env_directories); do
        # echo "Processing dir $i"
        new_index=$(echo "$active + $i - 1" | bc)
        if [ $i -gt 1 ]; then
            # echo "Creating new window"
            tmux new-window
            if [ $delta -gt 0 ]; then
                # move all the windows to the left to make room for new ones
                # echo "Moving to $new_index"
                tmux swap-window -t $new_index
            fi
        fi
        local -a data
        row="${dev_env_directories[$i]}"
        data=("${(@s/|/)row}")
        # echo "Data to process: $data, from $row"
        cmd="cd ${data[1]}"
        name="${data[1]}"
        if [ -n "${data[3]}" ]; then
            cmd="$cmd && workon ${data[3]}"
        fi
        if [ -n "${data[2]}" ]; then
            cmd="$cmd && ${data[2]}"
            name="${data[2]}"
        fi
        short="$(echo $name | sed -e 's/^\(.\{6\}\).*/\1/g' -e 's/[ ]\+$//g')"
        if [ "$(echo $name | wc -m)" -ne "$(echo $short | wc -m)" ]; then
            short="$short.."
        fi
        # tmux send-keys C-z "$cmd" Enter
        tmux set-option allow-rename off
        tmux send-keys "$cmd" C-m
        tmux rename-window "$short"
        # tmux send-keys -t :.4 C-z "cd \"$(pwd)\"; $*" Enter
    done

    tmux select-window -t:$active
}
# }}}

function whatsmyip() {
# {{{
    dig +short myip.opendns.com @resolver1.opendns.com
}
# }}}

function to_git_branch {
# {{{
    echo "$1\n" | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/ /g' -e 's/[^a-zA-Z0-9 ]//g' -e 's/\s\+/_/g' -e 's/_\+$//g' -e 's/\(.*\)/\L\1/g'
# }}}
}

# }}}

if [ -e "$HOME/.zshrc_local" ]; then
    source ~/.zshrc_local
fi

# export MANPATH="/usr/local/man:$MANPATH"
if [ -d "/usr/lib/jvm/java-8-oracle" ]; then
    export JAVA_HOME=/usr/lib/jvm/java-8-oracle
fi

export BROWSER=/usr/local/bin/chromium
export EDITOR=/usr/local/bin/vim
if [ "$(uname -s)" != "Darwin" ]; then
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2
    export BROWSER=/usr/bin/chromium
    export EDITOR=/usr/bin/vim
fi
export PAGER="less -FRX"

if [ -x "$(command -v git)" ] && [ "diffconflicts" != "$(git config --global merge.tool)" ]; then
# Git config {{{
    git config --global merge.tool diffconflicts
    git config --global mergetool.diffconflicts.cmd 'diffconflicts vim $BASE $LOCAL $REMOTE $MERGED'
    git config --global mergetool.diffconflicts.trustExitCode true
    git config --global mergetool.diffconflicts.keepBackup false
# }}}
fi

if [ ! -f ~/.zgen/zgen.zsh ]; then
# zgen config {{{
  pushd ~
  git clone https://github.com/tarjoilija/zgen.git .zgen
  popd
# }}}
fi
source ~/.zgen/zgen.zsh

TPM_PATH=~/.tmux/plugins/tpm
if [ ! -d $TPM_PATH ]; then
    mkdir -p $TPM_PATH
    git clone https://github.com/tmux-plugins/tpm $TPM_PATH
fi

if [ -s "$HOME/.gvm/scripts/gvm" ]; then
    source "$HOME/.gvm/scripts/gvm"
fi

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

if [ ! -f "$HOME/.zgen/init.zsh" ]; then
# Zgen config {{{
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # zgen load RobSis/zsh-completion-generator
    # zgen load petervanderdoes/git-flow-completion

    zgen oh-my-zsh plugins/git
    # zgen oh-my-zsh plugins/command-not-found
    zgen oh-my-zsh plugins/docker
    zgen oh-my-zsh plugins/docker-compose
    zgen oh-my-zsh plugins/jsontools
    # zgen oh-my-zsh plugins/python
    # zgen oh-my-zsh plugins/golang
    zgen oh-my-zsh plugins/virtualenvwrapper
    zgen oh-my-zsh plugins/bgnotify
    zgen oh-my-zsh plugins/sudo
    # zgen oh-my-zsh plugins/tmux
    # zgen oh-my-zsh plugins/tmux-cssh
    zgen oh-my-zsh plugins/compleat
    zgen oh-my-zsh plugins/encode64
    zgen oh-my-zsh plugins/httpie
    zgen oh-my-zsh plugins/history
    # zgen oh-my-zsh plugins/pip
    zgen oh-my-zsh plugins/urltools
    # zgen oh-my-zsh plugins/aws
    zgen oh-my-zsh plugins/colored-man-pages
    zgen oh-my-zsh plugins/colorize
    # zgen oh-my-zsh plugins/cp
    # zgen oh-my-zsh plugins/catimg
    zgen oh-my-zsh plugins/nmap

    zgen load zsh-users/zsh-syntax-highlighting
    # zgen load arzzen/calc.plugin.zsh
    zgen load dgnest/zsh-gvm-plugin

    # autosuggestions should be loaded last
    zgen load tarruda/zsh-autosuggestions
    zgen save
# }}}
fi

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"

# You may need to manually set your language environment
export LANG=en_GB.UTF-8

# Aliases {{{

alias ll="ls -la"
alias clearpyc="find . -name '*.pyc' -delete"
alias tmux="TERM='xterm-256color' tmux -u"
alias irssi="TERM=screen-256color irssi"
alias sudo='sudo '

# }}}

if [ -e "$(which xmodmap)" ]; then
    xmodmap -e "keycode 166=Prior"
    xmodmap -e "keycode 167=Next"
fi

# Python and pyenv setup {{{
if [ -e "$(which powerline-daemon)" ]; then
    powerline-daemon -q
fi

if [ -f "/usr/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh" ]; then
    export POWERLINE_ROOT=/usr/lib/python3.7/site-packages/powerline
elif [ -f "/usr/local/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh" ]; then
    export POWERLINE_ROOT=/usr/local/lib/python3.7/site-packages/powerline
elif [ -f "/usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh" ]; then
    export POWERLINE_ROOT=/usr/local/lib/python2.7/site-packages/powerline
elif [ -f "/usr/local/lib/python2.7/dist-packages/powerline/bindings/zsh/powerline.zsh" ]; then
    export POWERLINE_ROOT=/usr/local/lib/python2.7/dist-packages/powerline
elif [ -f "/usr/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh" ]; then
    export POWERLINE_ROOT=/usr/lib/python2.7/site-packages/powerline
fi

. $POWERLINE_ROOT/bindings/zsh/powerline.zsh

export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# if [ -d "$PYENV_ROOT/plugins" -a ! -d "$PYENV_ROOT/plugins/pyenv-virtualenvwrapper" ]; then
#     pushd ~
#     git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $PYENV_ROOT/plugins/pyenv-virtualenvwrapper
#     popd
# fi

# Lazy load pyenv
if type pyenv &> /dev/null; then
    function pyenv() {
        unset -f pyenv > /dev/null 2>&1
        eval "$(command pyenv init -)"
        pyenv "$@"
    }
fi
# eval "$(pyenv init -")

# Lazy load pyenv-virtualenv
if type pyenv-virtualenv &> /dev/null; then
    function pyenv-virtualenv() {
        unset -f pyenv-virtualenv > /dev/null 2>&1
        eval "$(command pyenv virtualenv-init -)"
        pyenv-virtualenv "$@"
    }
fi
# eval "$(pyenv virtualenv-init -)"
# pyenv virtualenvwrapper

[[ -s "/usr/local/etc/grc.bashrc"  ]] && source /usr/local/etc/grc.bashrc
# [[ -s "/usr/local/etc/grc.zsh"  ]] && source /usr/local/etc/grc.zsh
# }}}

unsetopt allexport
