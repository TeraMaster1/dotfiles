#!/bin/bash
cmd=$(compgen -c | sort -u | fzf --prompt='> ') || exit
nohup bash -c "$cmd" >/dev/null 2>&1 
