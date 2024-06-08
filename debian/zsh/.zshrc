#------------------------------
# Oh My Zsh 
#------------------------------
ZSH_THEME="matias"

plugins=(
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
)

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

#------------------------------
# Exports 
#------------------------------

typeset -U path PATH
path=($path "$HOME/.local/bin")
#path=($path "$HOME/.dotnet/tools")
#path=($path "/usr/local/go/bin")
#path=($path "/opt/mssql-tools18/bin")
export PATH

#export DOTNET_ROOT=/usr/share/dotnet
#export GOPATH="$HOME/go"

export XDG_CONFIG_HOME=$HOME/.config
export COMMON_DIRS="$HOME $HOME/database/Personal/ $HOME/database/UBA $HOME/.local" 

#------------------------------
# History 
#------------------------------
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

#------------------------------
# cd 
#------------------------------

setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

function fuzzy_open {

    local HOME_DIRS PWD_DIRS DESTINATION

    HOME_DIRS=$(fdfind -H -d 1 . $(echo $COMMON_DIRS))
    
    if [ "$(pwd)" = "$HOME" ]; then
        PWD_DIRS=""
    else
        PWD_DIRS=$(fdfind -H . .)
    fi
    
    DESTINATION=$(echo $HOME_DIRS $PWD_DIRS | fzf)
    
    if [ -d "$DESTINATION" ]; then
        cd $DESTINATION
    elif [ -f "$DESTINATION" ]; then
        opend $DESTINATION
    fi

    zle accept-line
}

zle -N fuzzy_open

#------------------------------
# Default Apps 
#------------------------------
export BROWSER="brave"
export EDITOR="nvim"

#------------------------------
# Alias 
#------------------------------
alias find='fdfind'
alias grep='rg'
alias vim='nvim'
alias ll='ls -hlF --group-directories-first'
alias lla='ls -ahlF --group-directories-first'
alias free='free -m'
alias ..="cd .."
alias d='dirs -v'
alias cp="cp -i"
alias mkdir="mkdir -pv"

#------------------------------
# Keybindings
#------------------------------

# enable vim mode
bindkey -v
bindkey '^f' fuzzy_open

#------------------------------
# Completions
#------------------------------

autoload -Uz compinit; compinit

#------------------------------
# FZF
#------------------------------
FZF_ALT_C_COMMAND= FZF_CTRL_T_COMMAND= source <(fzf --zsh)

#------------------------------
# Custom Functions
#------------------------------

### ARCHIVE EXTRACTION
# usage: ex <file>
ex () {
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unar x $1    ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

### OPEN FILE IN BACKGROUND DETACH FOR THE CURRENT SHELL
# usage: opend <file>
opend() {
  if [ -f "$1" ] ; then
    nohup open "$1" > /dev/null 2>&1 &
  else
    echo "'$1' is not a valid file"
  fi
}

#------------------------------
# Starts a new tmux session
#------------------------------
if [ ! -n "$TMUX" ]; then
    tmux new-session -A -s main
fi

