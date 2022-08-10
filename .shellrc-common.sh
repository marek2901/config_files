# ######### GENERIC ALIASES
alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'
# override ll with exa if it exists
if which exa &> /dev/null; then
  alias ll='exa --colour=always --long --header'
fi

alias ifmyip4="ifconfig | grep -E 'inet\ \d+.*broadcast' | grep -Eo 'inet \d+\.\d+\.\d+\.\d+' | cat"

alias reztart="case '$-' in *i*) clear; exec sudo --login --user $USER exec bash -c \"cd \$PWD && exec \$(echo \${0#'-'} | xargs which)\" ;; *) echo reztart only interactive shells ;; esac"

if which batcat &> /dev/null; then
  alias cat="batcat"
fi

if which bat &> /dev/null && bat --help | grep -o "A cat(1) clone with syntax highlighting and Git integration" &> /dev/null; then
  alias cat="bat"
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  if which xclip &> /dev/null; then
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
  else
    echo "Install xclip to enable pbcopy and pbpaste on linux"
  fi
fi
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

if which tmate &> /dev/null; then
  alias tmatetmux='TMUX= tmux'
fi

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

if test -d "$HOME/.local-bin"; then
  export PATH="$PATH:$HOME/.local-bin"
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

function relaxing_breathing() {
  function mantra() {
    if which lolcat &> /dev/null; then
      echo -en "\r\033[K      $1" | lolcat -p .8
    else
      echo -en "\r\033[K      $1"
    fi
  }
  function sleepcount() {
    for i in {1..4}; do echo -en " $i" && sleep 1; done
  }
  while true; do
    mantra "Breathe in"
    sleepcount
    mantra "Hold air in your lungs"
    sleepcount
    mantra "Exhale"
    sleepcount
    mantra "Hold your breath, lungs emptied"
    sleepcount
  done
}

if which sshuttle &> /dev/null; then
  function sshuttle-all() {
    sshuttle --remote=$1 0.0.0.0/0 ::/0
  }
fi

if which emacs &> /dev/null &&
    test -d "$HOME/.emacs.d/" &&
    test -f "$HOME/.spacemacs"; then
  function spacemacs() {
    emacs $@ &
  }
fi

if [[ -s "$HOME/.idea/bin/idea.sh" ]]; then
  function idea() {
    ~/.idea/bin/idea.sh $@ &>! "$HOME/.var/log/$(whoami)idea.log" &
    disown
  }
fi


if which ranger &> /dev/null; then
  ran() {
      temp_file="$(mktemp -t "ranger_cd.XXXXXXXXXX")"
      ranger --choosedir="$temp_file" -- "${@:-$PWD}"
      if chosen_dir="$(cat -- "$temp_file")" && [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
          cd -- "$chosen_dir"
      fi
      rm -f -- "$temp_file"
  }
fi
if which fff &> /dev/null; then
f() {
    fff "$@"
    cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}
fi
####### FUNCTIONS END

### podman alias (only if there is no docker aside)
if which podman &> /dev/null && ! which docker &> /dev/null; then
  alias docker=podman
fi

### podman-compose alias (only if there is no docker-compose aside)
if which podman-compose &> /dev/null && ! which docker-compose &> /dev/null; then
  alias docker-compose=podman-compose
fi

### KIEX
if test -s "$HOME/.kiex/scripts/kiex"; then
    source "$HOME/.kiex/scripts/kiex"
fi
###

### Rustup
if test -s "$HOME/.cargo/env"; then
  source "$HOME/.cargo/env"
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
if [[ -d  "$HOME/.pyenv" ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
fi
if [[ -d  "$HOME/.pyenv/bin" ]]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
fi
if which pyenv &> /dev/null; then
    eval "$(pyenv init --path)"
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

### java sdkman
if [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
  export SDKMAN_DIR="$HOME/.sdkman"
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

### PHP phpenv
if [[ -d  "$HOME/.phpenv/bin" ]]; then
    export PATH="$HOME/.phpenv/bin:$PATH"
fi
if which phpenv &> /dev/null; then
  eval "$(phpenv init -)";
fi
###
