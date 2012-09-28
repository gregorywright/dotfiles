# .bashrc
export GREP_OPTIONS="--exclude=\*.svn\*"

export HISTFILESIZE=10000
export HISTSIZ=10000
export HISTSIZE=10000

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
#export PS1='\u@\h:\W$(__git_ps1 "(%s)")\$'
export PS1='\[\033[0;32m\][\u@\h:\W]\[\033[0;31m\]$(__git_ps1 "(%s)")\[\033[0m\]'
alias svndiff='svn diff --diff-cmd diff -x -uw'
# User specific aliases and functions
alias ls='ls --color -CGF'
alias h='history'
alias grep='grep --color'

source /etc/bash_completion.d/git

