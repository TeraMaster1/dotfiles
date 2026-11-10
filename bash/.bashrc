#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# export XDG_CACHE_HOME="${HOME}/.cache"
# export XDG_CONFIG_HOME="${HOME}/.config"
# export XDG_DATA_HOME="${HOME}/.local/share"
# export XDG_STATE_HOME="${HOME}/.local/state"
#
# if test -z "${XDG_RUNTIME_DIR}"; then
#     export XDG_RUNTIME_DIR=/run/user/${UID}
# fi
#
# if test -d "${XDG_RUNTIME_DIR}"; then
#     perms="$(stat -c '%a %u' "${XDG_RUNTIME_DIR}")"
#     if [[ "${perms}" != "700 ${UID}" ]]; then
#         export -n XDG_RUNTIME_DIR
#         echo "WARNING! XDG_RUNTIME_DIR has incorrect permissions"
#     fi
# else
#     mkdir -p "${XDG_RUNTIME_DIR}"
#     chmod 0700 "${XDG_RUNTIME_DIR}"
# fi

alias ls='ls --color'
alias grep='grep --color'
# PS1='[\u@\h \W]\$ '

# export PATH="/home/fjodor/.local/bin:~/.local/share/smgo-manager:~/go/bin:~/.config/emacs/bin/:$PATH"

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

#XKB_DEFAULT_LAYOUT=se
#XKB_DEFAULT_VARIANT=dvorak
