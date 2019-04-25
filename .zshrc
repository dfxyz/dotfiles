# DF_XYZ's Zsh Configurations

# General Options
setopt KSH_ARRAYS
unsetopt FLOW_CONTROL

# History
setopt HIST_IGNORE_ALL_DUPS
unsetopt HIST_SAVE_BY_COPY
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=1000

# Completion
autoload -Uz compinit
compinit
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
[[ -n $SSH_CONNECTION ]] && remoteMarker=*
PS1=$'\e]0;zsh: %~\a'
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
[[ -e ~/.exports ]] && source ~/.exports
[[ -e ~/.aliases ]] && source ~/.aliases
