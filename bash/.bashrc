#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color'
alias grep='grep --color'
PS1='[\u@\h \W]\$ '

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

eval "$(starship init bash)"

#XKB_DEFAULT_LAYOUT=se
#XKB_DEFAULT_VARIANT=dvorak
