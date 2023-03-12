# Set up the prompt

autoload -Uz promptinit
promptinit
PROMPT='%B%F{green}%n@%m%F{white}:%F{blue}%~%F{white}%b$ '

autoload -Uz compinit
compinit

setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

bindkey -v
export KEYTIMEOUT=1

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

# FUNCTIONS
function _tree() {
    if [ -d "$2" ]; then
        tree -L $@ | less --no-init --quit-if-one-screen
    else
        tree ./ -L $@ | less --no-init --quit-if-one-screen
    fi;
}
function _fastfind() {
    find -O3 $@ 2> /dev/null
}
function md() {
    pandoc $1 | lynx -stdin
}
function man7() {
    lynx "https://lite.duckduckgo.com/lite?q=${*// /+}+site:man7.org/linux/man-pages"
}
function duckduckgo() {
    lynx "https://lite.duckduckgo.com/lite?q=${*// /+}"
}
# ALIASES
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

alias t='_tree 0'
alias t1='_tree 1'
alias t2='_tree 2'
alias t3='_tree 3'
alias t4='_tree 4'

alias ff='_fastfind'

alias '?'='duckduckgo'
