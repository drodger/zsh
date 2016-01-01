# shell options as history size, keybindings, etc

export GREP_OPTIONS='--binary-files=without-match --ignore-case'

# History Settings (big history for use with many open shells and no dups)
# Different History files for root and standard user
if (( ! EUID )); then
    HISTFILE=$ZSH_CACHE/history_root
else
    HISTFILE=$ZSH_CACHE/history
fi
SAVEHIST=10000
HISTSIZE=12000
setopt share_history append_history extended_history hist_no_store hist_ignore_all_dups hist_ignore_space
