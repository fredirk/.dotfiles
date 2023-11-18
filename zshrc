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
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify

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

if [ -d "$HOME/.local/bin" ]; then
    export PATH="$PATH:$HOME/.local/bin"
fi
if [ -d "$HOME/Android/Sdk" ]; then
    export ANDROID_HOME=$HOME/Android/Sdk
    export PATH=$PATH:$ANDROID_HOME/emulator
    export PATH=$PATH:$ANDROID_HOME/platform-tools
fi
if [ -d "$HOME/.npm-global" -a ! -d "$HOME/.nvm" ]; then
    export NPM_CONFIG_PREFIX=~/.npm-global
fi
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi
if [ -f "/usr/bin/dotnet" ]; then
    export DOTNET_ROOT=/usr/bin/dotnet
fi
export PICO_SDK_PATH=$HOME/src/pico/pico-sdk
export PICO_EXAMPLES_PATH=$HOME/src/pico/pico-examples
export PICO_EXTRAS_PATH=$HOME/src/pico/pico-extras
export PICO_PLAYGROUND_PATH=$HOME/src/pico/pico-playground

export EMSDK_QUIET=1
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin

[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# PLUGINS
if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    # https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
    . ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#999999"
fi
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    # https://github.com/zsh-users/zsh-syntax-highlighting
    . ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
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
function kctx() {
    case "$1" in
        "")
            kubectl config get-contexts
            ;;
        "use")
            if [ -z "$2" ]; then
                echo "Usage: kctx use <context-name>"
            else
                kubectl config use-context "$2"
            fi
            ;;
        "current")
            kubectl config current-context
            ;;
        *)
            echo "Usage: kctx [use <context-name>] [current]"
            ;;
    esac
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
    alias zgrep='zgrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m' 
    export LESS_TERMCAP_md=$'\E[1;36m' 
    export LESS_TERMCAP_me=$'\E[0m'    
    export LESS_TERMCAP_so=$'\E[01;33m' 
    export LESS_TERMCAP_se=$'\E[0m'
    export LESS_TERMCAP_us=$'\E[1;32m'
    export LESS_TERMCAP_ue=$'\E[0m'
fi

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
alias 'history'='history 0'

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ........="cd ../../../../../../.."
alias .........="cd ../../../../../../../.."
alias ..........="cd ../../../../../../../../.."

alias k='kubectl'
