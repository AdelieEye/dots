#!/usr/bin/env bash

choose="$(printf "codeforces\ncses\nleetcode\ncontest" | dmenu -b -i -l 15 \
                        -p 'sys:'   \
                        -nb '#0d0401' \
                        -nf '#ebdbb2' \
                        -sb '#403833' \
                        -sf '#ebdbb2' )"

[[ -z $choose ]] && exit 0

mk() { mkdir -p "$(date +%F)"; }
ck() { cd "$(date +%F)" || exit; }


if [[ $choose == "contest" ]]; then
    cd "$HOME/cdiode" || exit
    mk
    ck
    round="$(printf "contest" | dmenu -b -i -l 15 \
                            -p 'sys:'   \
                            -nb '#0d0401' \
                            -nf '#ebdbb2' \
                            -sb '#403833' \
                            -sf '#ebdbb2' )"

    [[ -z $round ]] && exit 0
    mkdir -p "$round"
    cd "$round" || exit
    touch "in.txt"
    touch "out.txt"
    tmux

else
    cd "$HOME/cdiode" || exit
    mk
    ck
    mkdir -p "$choose"
    cd "$choose" || exit
    touch "in.txt"
    touch "out.txt"
    tmux
fi
