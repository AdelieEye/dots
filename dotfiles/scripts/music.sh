#!/usr/bin/env bash

choose="$({
            echo "download"
            fd -tf . "$HOME/music/" 
            } | dmenu -b -i -l 15 \
                        -p 'music:'   \
                        -nb '#0d0401' \
                        -nf '#ebdbb2' \
                        -sb '#403833' \
                        -sf '#ebdbb2' )"

[[ -z $choose ]] && exit

if [[ $choose == "download" ]]; then
    link="$(wl-paste)"
    link_cleaned="${link%%&list*}"
    name="$(echo "" | dmenu -b -i -l 15 \
                            -p "name:"   \
                            -nb '#0d0401' \
                            -nf '#ebdbb2' \
                            -sb '#403833' \
                            -sf '#ebdbb2' )"

    [[ -z $name ]] && exit
    cd "$HOME/music" || exit
    yt-dlp -f ba "$link_cleaned" -o "$name.webm"

    status=$?
    if [ "$status" -ne 0 ]; then
        notify-send "yt-dlp failed with exit code: $status"
    else
        echo "$name -> $link" >> "$HOME/music.txt"
        notify-send "$name, Download Done"
    fi

else
    pkill ffplay &>/dev/null
    ffplay  \
        -loop 0   \
        -loglevel quiet \
        "$choose" \
        &> /dev/null
fi
