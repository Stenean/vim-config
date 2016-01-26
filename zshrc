# User configuration

export PATH="/home/$USER/.vim/bin/:/home/$USER/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"
# export MANPATH="/usr/local/man:$MANPATH"
export EDITOR='vim'

if [ -x "$(command -v git)" ] && [ "diffconflicts" != "$(git config --global merge.tool)" ]; then
    git config --global merge.tool diffconflicts
    git config --global mergetool.diffconflicts.cmd 'diffconflicts vim $BASE $LOCAL $REMOTE $MERGED'
    git config --global mergetool.diffconflicts.trustExitCode true
    git config --global mergetool.diffconflicts.keepBackup false
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

AUTOSUGGESTION_HIGHLIGHT_COLOR="fg=10"
AUTOSUGGESTION_HIGHLIGHT_CURSOR=0
AUTOSUGGESTION_ACCEPT_RIGHT_ARROW=1

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git, command-not-found, docker, jsontools, python, suprevisor, virtualenvwrapper)

if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/command-not-found
    zgen oh-my-zsh plugins/docker
    zgen oh-my-zsh plugins/jsontools
    zgen oh-my-zsh plugins/python
    zgen oh-my-zsh plugins/suprevisor
    zgen oh-my-zsh plugins/virtualenvwrapper

    zgen load zsh-users/zsh-syntax-highlighting

    # autosuggestions should be loaded last
    zgen load tarruda/zsh-autosuggestions
    zgen save
fi

# zgen init
zle-line-init() {
    zle autosuggest-start
}
zle -N zle-line-init

# source $ZSH/oh-my-zsh.sh

function workon_cwd {
    # Check that this is a Git repo
    GIT_DIR=`git rev-parse --git-dir 2> /dev/null`
    if [ $? = 0 ]; then
        # Find the repo root and check for virtualenv name override
        PROJECT_ROOT=`dirname "$GIT_DIR"`
        if [ "$PROJECT_ROOT" = "." ]; then
            PROJECT_ROOT=`pwd`
        fi

        ENV_NAME=`basename "$PROJECT_ROOT"`
        if [ -f "$PROJECT_ROOT/.venv" ]; then
            ENV_NAME=`cat "$PROJECT_ROOT/.venv"`
        fi

        if [ "$CD_VIRTUAL_ENV" != "$ENV_NAME" -a "$CD_VIRTUAL_ENV" != "" ]; then
            deactivate && unset CD_VIRTUAL_ENV
        fi

        # Activate the environment only if it is not already active
        if [ "$VIRTUAL_ENV" != "$WORKON_HOME/$ENV_NAME" -a "$VIRTUAL_ENV" != "$PROJECT_HOME/$ENV_NAME" ]; then
            if [ -e "$WORKON_HOME/$ENV_NAME/bin/activate" ]; then
                workon "$ENV_NAME" && export CD_VIRTUAL_ENV="$ENV_NAME"
            fi
        fi
    elif [ $CD_VIRTUAL_ENV ]; then
        # We've just left the repo, deactivate the environment
        # Note: this only happens if the virtualenv was activated automatically
        deactivate && unset CD_VIRTUAL_ENV
    fi
}

# New cd function that does the virtualenv magic
# cd() {
#     builtin cd "$@"
#     workon_cwd
# }

# You may need to manually set your language environment
export LANG=pl_PL.UTF-8

alias ll="ls -la"
alias clearpyc="find . -name '*.pyc' -delete"
alias tmux="TERM='xterm-256color' tmux"

. /usr/local/lib/python2.7/dist-packages/powerline/bindings/zsh/powerline.zsh

export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv virtualenvwrapper
