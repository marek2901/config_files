########## ZIM FRAMEWORK
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

if test -s ${ZIM_HOME}/init.zsh; then
    source ${ZIM_HOME}/init.zsh
elif; then
    echo "install zim https://github.com/zimfw/zimfw"
    return 1
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

source "$HOME/.shellrc-common.sh"
