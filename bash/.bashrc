#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color'
alias grep='grep --color'
PS1='[\u@\h \W]\$ '

export PATH="/home/fjodor/.local/bin:~/.local/share/smgo-manager:~/go/bin:~/.config/emacs/bin/:$PATH"

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

#XKB_DEFAULT_LAYOUT=se
#XKB_DEFAULT_VARIANT=dvorak
