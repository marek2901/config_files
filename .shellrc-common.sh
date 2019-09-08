########## GENERIC ALIASES
alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'

alias ifmyip4="ifconfig | grep -E 'inet\ \d+.*broadcast' | grep -Eo 'inet \d+\.\d+\.\d+\.\d+' | cat"
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

########## OPTIONS
export EDITOR='vim'
########## OPTIONS END

########## WORKAROUNDS
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export LESS='-RI'
export GIT_INTERNAL_GETTEXT_TEST_FALLBACKS=1

### Pipsi or pipx binaries
if test -d "$HOME/.local/bin"; then
  export PATH="$HOME/.local/bin:$PATH"
fi

### User added script/bin files
if test -d "$HOME/.bin"; then
    export PATH="$HOME/.bin:$PATH"
fi

### homebrew path modifications
if [[ "$OSTYPE" == "darwin"* ]] && test -d "/usr/local/sbin"; then
  export PATH="/usr/local/sbin:$PATH"
fi

### I wanna copy paste in mitmproxy plz
if which mitmproxy &> /dev/null; then
  alias mitmproxy="mitmproxy --set console_mouse=false "
fi

### Poetry
if which poetry &> /dev/null; then
  poetryvenv() {
    local poepypath=$(poetry run which python 2> /dev/null)
    if [[ ! -z "$poepypath" ]]; then
      . "$(dirname "$poepypath")/activate"
    else
      return 112
    fi
  }
fi
########## WORKAROUNDS END

# FUNCTIONS
if which ag &> /dev/null; then
  agr() { ag -0 -l "$1" | xargs -0 sed -i '' -e "s/$1/$2/g"; }
fi

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

### KIEX
if test -s "$HOME/.kiex/scripts/kiex"; then
    source "$HOME/.kiex/scripts/kiex"
fi
###

### rust Cargo
if test -d "$HOME/.cargo/bin"; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi
###

### ruby Rbenv
if [[ -d  "$HOME/.rbenv/bin" ]]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
fi
if which rbenv &> /dev/null; then
  eval "$(rbenv init -)";
fi
###

### python PyEnv
if [[ -d  "$HOME/.pyenv/bin" ]]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
fi
if which pyenv &> /dev/null; then
    eval "$(pyenv init - --no-rehash)"
fi
if [[ -s "$HOME/.pyenv/plugins/pyenv-virtualenv/bin/pyenv-virtualenv-init" ]] ||
    which pyenv-virtualenv-init &> /dev/null; then
    eval "$(pyenv virtualenv-init -)"
fi
###

### nodejs NodEnv
if [[ -d  "$HOME/.nodenv/bin" ]]; then
    export PATH="$HOME/.nodenv/bin:$PATH"
fi
if which nodenv &> /dev/null; then
  eval "$(nodenv init -)";
fi
####

### go GoEnv
if [[ -d  "$HOME/.goenv" ]]; then
    export GOENV_ROOT="$HOME/.goenv"
    [[ -d "$GOENV_ROOT/bin" ]] &&
      export PATH="$GOENV_ROOT/bin:$PATH"
fi
if which goenv &> /dev/null; then
    eval "$(goenv init -)"
fi
###
