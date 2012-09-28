export HISTFILESIZE=5000
export HISTSIZ=5000
export HISTSIZE=5000

export SVN_EDITOR="emacs -nw"
alias svndiff='svn diff --diff-cmd diff -x -uw'
alias mc='make copy'
alias env='env | sort'
alias maek='make'
alias mkae='make'
alias amek='make'
alias mkae='make'
alias amke='make'
alias emak='make'
alias kema='make'
alias akem='make'
alias mak='make'
alias ake='make'

alias locate='locate -i'

export GREP_OPTIONS="--exclude=\*.svn\*"
alias grep='grep --color -s'
alias fgrep='fgrep --color -s'

alias ls='ls -G  -CF'
alias ll='ls -lh'
alias r='fc -s'
alias more=less
alias xterm='xterm -sb -sl 1000'
alias eterm='Eterm --scrollbar-right 0 --menubar 0'
alias h='history'
alias j='jobs'
alias findit='find . -name '
#export PS1="\[\033[0;32m\][\w]\[\033[0m\]" 
export PS1='\[\033[0;32m\][\W]\[\033[0;31m\]$(__git_ps1 "(%s)")\[\033[0m\]'
export CVS_RSH=ssh

export PROMPT_COMMAND='echo -ne "\033]0;${PWD}\007"'

alias remove~='find . -name "*~" -exec rm {} \; -print'

export BUILD_ROOT=$HOME/ribosome/build
export PATH=$HOME/bin:/usr/sbin:/bin:$BUILD_ROOT/bin:/usr/local/sbin:$PATH
export PATH=$HOME/Library/Haskell/bin:$PATH
export PATH=~/.cabal/bin:$PATH


source ~/.git-completion.bash
