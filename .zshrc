# DF_XYZ's Zsh Configurations

# General Options
setopt KSH_ARRAYS NO_FLOW_CONTROL

# History
setopt HIST_IGNORE_ALL_DUPS
mkdir -p ~/.cache
HISTFILE=~/.cache/zsh_history
HISTSIZE=1000
SAVEHIST=$HISTSIZE

# Completion
fpath=(~/.zsh/completion ${fpath[@]})
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
if [[ -n $MSYSTEM ]]; then
    DRIVES=$(mount | sed -n 's|^[A-Z]: on /\([a-z]\).*|\1|p')
    zstyle ':completion:*' fake-files /: "/:$DRIVES"
    unset DRIVES
fi

# Window title & prompt
setopt PROMPT_SUBST
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats $'\e[36m(%b)\e[0m'
[[ -n $SSH_CONNECTION ]] && { remoteMarker=*; remoteTitle=' (remote)'; }
PS1=$'\e]0;zsh: %~$remoteTitle\a'
PS1=$PS1$'\e[32m%n@%m\e[0m$remoteMarker \e[33m%~\e[0m ${vcs_info_msg_0_}\n'
PS1=$PS1'%(!.#.$) '
precmd() { vcs_info }

# Key bindings
bindkey "^[[H"      beginning-of-line       # Home
bindkey "^[[1~"     beginning-of-line       # Home
bindkey "^[[F"      end-of-line             # End
bindkey "^[[4~"     end-of-line             # End
bindkey "^[[5~"     beginning-of-history    # PageUp
bindkey "^[[6~"     end-of-history          # PageDown
bindkey "^[[2~"     overwrite-mode          # Insert
bindkey "^[[3~"     delete-char             # Delete
bindkey "^[[3;5~"   delete-word             # Ctrl-Delete
bindkey "^_"        backward-delete-word    # Ctrl-Backspace
bindkey "^[[1;5D"   backward-word           # Ctrl-Left
bindkey "^[[1;5C"   forward-word            # Ctrl-Right

# Source exports & aliases
[[ -f ~/.sources ]] && source ~/.sources
