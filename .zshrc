########## ZIM FRAMEWORK
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

if test -s ${ZIM_HOME}/init.zsh; then
    source ${ZIM_HOME}/init.zsh
elif; then
    echo "install zim https://github.com/zimfw/zimfw"
    return 1
fi
### Zim workarounds
if which zstyle &> /dev/null; then
  zstyle ':zim:git-info:clean' format '%F{green}✓'
  zstyle ':zim:git-info:dirty' format '%F{yellow}✓'
fi
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
