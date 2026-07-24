#!/bin/bash
cmd=$(compgen -c | sort -u | fzf --prompt='> ') || exit
setsid "$cmd" </dev/null >/dev/null 2>&1 &
sleep 1
