########## ZIM FRAMEWORK
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

if test -s ${ZIM_HOME}/init.zsh; then
    setopt HIST_IGNORE_ALL_DUPS
    bindkey -e
    WORDCHARS=${WORDCHARS//[\/]}
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
    if [[ ${ZIM_HOME}/init.zsh -ot ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
      source ${ZIM_HOME}/zimfw.zsh init -q
    fi
    source ${ZIM_HOME}/init.zsh
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down

    zmodload -F zsh/terminfo +p:terminfo
    if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
      bindkey ${terminfo[kcuu1]} history-substring-search-up
      bindkey ${terminfo[kcud1]} history-substring-search-down
    fi

    bindkey '^P' history-substring-search-up
    bindkey '^N' history-substring-search-down
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down
elif; then
    echo "install zim https://github.com/zimfw/zimfw"
    return 1
fi
### Zim workarounds
if which zstyle &> /dev/null; then
  zstyle ':zim:git-info:clean' format '%F{green}✓'
  zstyle ':zim:git-info:dirty' format '%F{yellow}✓'
fi
# I wanna lowercase g for git
alias g='G '
########## ZIM FRAMEWORK END

########## GENERIC ALIASES
alias reload-shell=". ~/.zshrc"
########## GENERIC ALIASES END

########## WORKAROUNDS
if [[ -d ~/.zsh-completions ]]; then
    fpath=(~/.zsh-completions $fpath)
fi
# TO RELOAD COMPLETEIONS TYPE:
alias refresh-completions="autoload -Uz compinit && compinit -i"
########## WORKAROUNDS END

########## LOCAL OVERRIDES
if test -s "$HOME/.zshrc.secret"; then
    ## STORE ENV VARS HERE
    source "$HOME/.zshrc.secret"
fi
if test -s "$HOME/.zshrc.local"; then
    ## STORE MACHINE SPECIFIC SETUP HERE
    source "$HOME/.zshrc.local"
fi
########## LOCAL OVERRIDES END

########## EDIT CURRENT LINE IN VIM
autoload -U edit-command-line
zle -N edit-command-line
# Type ctrl+x and ctrl+e sequentially
bindkey '^x^e' edit-command-line
# Type ctrl+x and e sequentially
bindkey '^xe' edit-command-line
########## EDIT CURRENT LINE IN VIM END

source "$HOME/.shellrc-common.sh"
