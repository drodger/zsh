[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $HOME/.config/zsh/environment.zsh

autoload -Uz compinit promptinit zcalc vcs_info
compinit
promptinit

setopt AUTO_CD
setopt CORRECT
setopt AUTO_PUSHD
setopt AUTO_NAME_DIRS
setopt GLOB_COMPLETE
setopt PUSHD_MINUS
setopt append_history no_inc_append_history no_share_history histignorealldups
setopt NO_HUP
setopt NO_BEEP
setopt extendedglob

# emacs keybindings
bindkey -e
export EDITOR="nvim"

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

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

autoload -U select-word-style
select-word-style bash

backward-kill-word(){
#    WORDCHARS='*?_-[]~\!#$%^(){}<>|`@#$%^*()+:?' zle backward-kill-word
    WORDCHARS='`~!@#$%^&*()-_=+[{]}\|;:",<.>/?'
}

zle -N bash-backward-kill-word

prompt fade red
NEWLINE=$'\n'
PROMPT='$fg_bold['white']$bg[red]%n@%m%{$reset_color%} $fg_color['white']%@${NEWLINE}%B%~ %b$(git_super_status) %# '

function psql() {
    if [[ $# -eq 0 ]]; then
        env psql --user postgres postgres
    else
        env psql --user postgres "$@"
    fi
}

en_py3
en_php
en_apa

