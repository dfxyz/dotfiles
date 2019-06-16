# DF_XYZ's Bash Configurations

# Window title & prompt
[[ -n $SSH_CONNECTION ]] && remoteMarker=*
[[ $EUID -ne 0 ]] && promptMarker=$ || promptMarker=#
PS1=$'\e]0;bash: $PWD\a'
PS1=$PS1$'\e[32m\u@\h\e[0m$remoteMarker \e[33m\w\e[0m'
if [[ -z "$WINELOADERNOEXEC" ]] ; then
    GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
    COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
    COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
    COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
    if [[ -f "$COMPLETION_PATH/git-prompt.sh" ]]; then
        . "$COMPLETION_PATH/git-completion.bash"
        . "$COMPLETION_PATH/git-prompt.sh"
        PS1=$PS1$'\e[36m`__git_ps1`\e[0m'
    fi
fi
PS1=$PS1$'\n$promptMarker '

# Source exports & aliases
[[ -e ~/.exports ]] && source ~/.exports
[[ -e ~/.aliases ]] && source ~/.aliases
