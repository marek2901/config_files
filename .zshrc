########## ZIM FRAMEWORK
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

if test -s ${ZIM_HOME}/init.zsh
then
    source ${ZIM_HOME}/init.zsh
elif
then
    echo "install zim https://github.com/zimfw/zimfw"
    return 1;
fi
########## ZIM FRAMEWORK END

########## GENERIC ALIASES
alias reload-shell=". ~/.zshrc"

alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'
########## GENERIC ALIASES END

########## GIT ALIASES
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias goc='git checkout '
alias gl='git log '
alias gpl='git pull '
alias got='git '
alias get='git '
########## GIT ALIASES END

########## WORKAROUNDS
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export LESS='-R'

if test -d "$HOME/.bin"
then
    export PATH="$HOME/.bin:$PATH"
fi
########## WORKAROUNDS END

########## LOCAL OVERRIDES
if test -s "$HOME/.zshrc.secret"
then
    source "$HOME/.zshrc.secret"
fi
########## LOCAL OVERRIDES END

# FUNCTIONS
man() {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
} # COLORS IN MAN
####### FUNCTIONS END

### Ruby RVM ### DEPRECATED
if test -d "$HOME/.rvm/bin"
then
    echo 'RVM is deprecated please use rbenv instead'
    export PATH="$PATH:$HOME/.rvm/bin"
fi
###

### KIEX
if test -s "$HOME/.kiex/scripts/kiex"
then
    source "$HOME/.kiex/scripts/kiex"
fi
###

### rust Cargo
if test -d "$HOME/.cargo/bin"
then
    export PATH="$HOME/.cargo/bin:$PATH"
fi
###

### ruby Rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
###

### python PyEnv
if which pyenv > /dev/null; then eval "$(pyenv init - --no-rehash)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
###

### nodejs NodEnv
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi
####
