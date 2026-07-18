#!/bin/bash
#bind -x '"\t":menu-complete'
#bind 'set show-all-if-ambiguous on'
#bind '"\t": complete'
#read -r -e -p "> " program
#exec nohup bash -c "$program" > /dev/null 2>&1 &

#bash -ic '
#    read -e -p "> " cmd
#    nohup bash -c "$cmd" >/dev/null 2>&1 &
#'

cmd=$(compgen -c | sort -u | fzf --prompt='> ') || exit
nohup bash -c "$cmd" >/dev/null 2>&1 &
