if tput colors > /dev/null 2>&1
then
  export PS1='\[\033[38;5;40m\][\[\033[38;5;9m\]`if [ $? = 0 ]; then echo "\[\033[01;32m\]ツ"; else echo "\[\033[01;31m\]✗"; fi`\[\033[38;5;40m\]]\[\033[38;5;14m\]-\[\033[38;5;83m\]\u\[\033[38;5;12m\]@\[\033[38;5;39m\]\h\[\033[38;5;15m\]:\[\033[38;5;6m\][\[\033[38;5;14m\]\W\[\033[38;5;6m\]]:\[\033[38;5;40m\]\\$\033[0m '
else
  export PS1='[`if [ $? = 0 ]; then echo "v"; else echo "x"; fi`]-\u@\h:[\W]:\\$ '
fi

alias g="git "

source "$HOME/.shellrc-common.sh"
