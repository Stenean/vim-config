# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export PATH="$HOME/.vim/bin:$HOME/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:$PATH"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

gpg_agent_command="gpg-agent --homedir $HOME/.gnupg --daemon"
gpg_agent_not_good=$(ps -Aopid,command | sed -e "\:$gpg_agent_command:!d" -e '/sed/d' -e 's/^[ \t]*//g' | cut -d' ' -f1)
gpg_agent_pid=$(ps -Aopid,command | sed -e '/gpg-agent/!d' -e '/sed/d' -e 's/^[ \t]*//g' | cut -d' ' -f1)
if [ -n "$gpg_agent_pid" -a -n "$gpg_agent_not_good" ]; then
    kill -9 $gpg_agent_pid
fi
eval $(eval $gpg_agent_command 2>/dev/null)

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# >>> BEGIN ADDED BY CNCHI INSTALLER
export BROWSER=/usr/local/bin/chromium
export EDITOR=/usr/local/bin/vim
if [ "$(uname -s)" != "Darwin" ]; then
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2
    export BROWSER=/usr/bin/chromium
    export EDITOR=/usr/bin/vim
fi
# <<< END ADDED BY CNCHI INSTALLER

if [ -s "$HOME/.gvm/scripts/gvm" ]; then
    source "$HOME/.gvm/scripts/gvm"
fi

export PROJECT_HOME="$HOME/Projects"
export WORKON_HOME="$HOME/.virtualenvs"
export PAGER="less -FRX"

DEFAULT_USER="kuba"

POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1

if [ -n "$(command -v xmodmap)" ]; then
    xmodmap -e "keycode 166=Prior"
    xmodmap -e "keycode 167=Next"
fi

function whatsmyip() {
    dig +short myip.opendns.com @resolver1.opendns.com
}

function find_and_activate_virtualenv() {
    if [ -n "$(env | grep -E '^VIRTUAL_ENV')" ]; then
        return;
    fi

    venvs=$(grep "$HOME" ~/.virtualenvs/*/.project | sed -e 's/\/.project//g' -e 's/\(.*\):\(.*\)/\2:\1/g')
    for venv in $venvs; do
        if [[ $PWD/ = $(echo $venv | sed -e 's/:.*//g')/* ]]; then
            curr_pwd=$PWD
            workon $(echo $venv | sed -e 's/.*://g' -e 's/.*\/\(.*\)$/\1/g')
            cd $curr_pwd
            return
        fi
    done
}

# Python and pyenv setup {{{
if [ -e "$(which powerline-daemon)" ]; then
    powerline-daemon -q
fi

if [ -f "/usr/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh" ]; then
    . /usr/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh
elif [ -f "/usr/local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh" ]; then
    . /usr/local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh
elif [ -f "/usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh" ]; then
    . /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
elif [ -f "/usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh" ]; then
    . /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh
elif [ -f "/usr/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh" ]; then
    . /usr/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
fi

export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv virtualenvwrapper

[[ -s "/etc/grc.bashrc"  ]] && source /etc/grc.bashrc

# }}}
