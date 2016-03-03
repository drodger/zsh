[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $HOME/.config/zsh/environment.zsh

autoload -Uz promptinit vcs_info
promptinit
prompt fire red


setopt histignorealldups sharehistory
# emacs keybindings
bindkey -e
setopt NO_HUP
export EDITOR="nvim"
setopt NO_BEEP
setopt extendedglob

autoload -Uz compinit
compinit

setopt AUTO_CD

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

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

typeset -ga sources
sources+="$ZSH_CONFIG/environment.zsh"
sources+="$ZSH_CONFIG/options.zsh"
# sources+="$ZSH_CONFIG/prompt.zsh"
# sources+="$ZSH_CONFIG/functions.zsh"
sources+="$ZSH_CONFIG/aliases.zsh"

sources+="$ZSH_CONFIG/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# completion config needs to be after system and private config
sources+="$ZSH_CONFIG/completion.zsh"

# fasd integration and config
sources+="$ZSH_CONFIG/fasd.zsh"
sources+="$ZSH_CONFIG/zsh-git-prompt/zshrc.sh"


# try to include all sources
foreach file (`echo $sources`)
    if [[ -a $file ]]; then
        source $file
    fi
end

x-bash-backward-kill-word(){
    WORDCHARS='' zle backward-kill-word
}
zle -N x-bash-backward-kill-word
bindkey '^W' x-bash-backward-kill-word

x-backward-kill-word(){
    WORDCHARS='*?_-[]~\!#$%^(){}<>|`@#$%^*()+:?' zle backward-kill-word
}
zle -N x-backward-kill-word
bindkey '\e^?' x-backward-kill-word

export PATH="/home/derek/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

NEWLINE=$'\n'
PROMPT='$fg_bold['white']$bg[red]%n@%m%{$reset_color%} $fg_color['white']%@${NEWLINE}$fg_bold['yellow']%~ %b$(git_super_status) '
