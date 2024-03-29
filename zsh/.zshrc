HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:/opt/mssql-tools18/bin"
export DOTNET_ROOT=/usr/share/dotnet
export GOPATH="$HOME/go"
export XDG_CONFIG_HOME=$HOME/.config
export ZSH="$HOME/.oh-my-zsh"
export REPOS="$HOME /mnt/database/BINIT/Repos/ /mnt/database/Personal/ /mnt/database/UBA/Algo2/Repos/ /mnt/database/UBA/Algo2/Repos/ /mnt/database/UBA/ALC/Repos/ /home/matias/.local" 

ZSH_THEME="matias"

autoload -Uz compinit promptinit
compinit
promptinit

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

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
alias cp="cp -i"
alias mkdir="mkdir -pv"

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

#------------------------------
# Keybindings
#------------------------------
bindkey -v
bindkey -s '^f' 'source ~/.local/scripts/directory-fzf\n'
bindkey -s '^l' 'clear\n'

source ~/.config/zsh/fzf/completion.zsh
source ~/.config/zsh/fzf/key-bindings.zsh

### ARCHIVE EXTRACTION
# usage: ex <file>
ex ()
{
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

