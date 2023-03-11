if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias python='python3'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias rm='rm -i'
alias clear='clear -x'

function _tree() {
    if [ -d "$2" ]; then
        tree -L $@ | less --no-init --quit-if-one-screen
    else
        tree ./ -L $@ | less --no-init --quit-if-one-screen
    fi;
}

alias t='_tree 0'
alias t1='_tree 1'
alias t2='_tree 2'
alias t3='_tree 3'
alias t4='_tree 4'

function _fastfind() { 
    find -O3 $@ 2> /dev/null 
}
alias ff='_fastfind'

function md() {
    pandoc $1 | lynx -stdin
}

