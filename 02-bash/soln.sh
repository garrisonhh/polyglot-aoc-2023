#! /usr/bin/env bash

error_exit () {
    msg="$1"
    >&2 echo "error: $msg"
    exit -1
}

show_usage () {
    error_exit "usage: $0 (part1|part2) <input-file.txt>"
}

# iterates over games. you can read output with:
# `each_game | while read -r gameno matches`
each_game () {
    cat $input_file \
        | sed -E 's/^Game ([0-9]+): (.+)$/\1 '\''\2\'\''/g'
}

# iterates through matches from each_game. read output with:
# `echo $matches | each_match | while read -r red green blue`
each_match () {
    read -r raw_matches

    IFS=';' read -ra matches <<< "${raw_matches//\'}"
    for match in "${matches[@]}"; do
        local red=0
        local green=0
        local blue=0

        IFS=',' read -ra marbles <<< "$match"
        for marble in "${marbles[@]}"; do
            read -r no color <<< "$marble"
            case $color in
            "red") red=$no;;
            "blue") blue=$no;;
            "green") green=$no;;
            esac

        done

        echo "$red $green $blue"
    done
    unset IFS
}

part1 () {
    local result=0
    while read -r gameno matches; do
        local valid=true
        while read -r red green blue; do
            if [[ $red -gt 12 ]]; then
                valid=false
                break
            elif [[ $green -gt 13 ]]; then
                valid=false
                break
            elif [[ $blue -gt 14 ]]; then
                valid=false
                break
            fi
        done <<< "$(echo $matches | each_match)"

        if $valid; then
            result=$((result + gameno))
        fi
    done <<< "$(each_game)"

    echo "part1: $result"
}

best () {
    read -ra arr <<< "$1"
    if [[ ${#arr[@]} -eq 0 ]]; then
        echo 0
        return
    fi

    local res="${arr[0]}"
    for x in "${arr[@]}"; do
        if [[ $x -lt $res ]]; then
            res=$x
        fi
    done

    echo "$res"
}

part2 () {
    local result=0
    while read -r gameno matches; do
        local min_red=0
        local min_green=0
        local min_blue=0
        while read -r red green blue; do
            if [[ $red -gt $min_red ]]; then min_red=$red; fi
            if [[ $green -gt $min_green ]]; then min_green=$green; fi
            if [[ $blue -gt $min_blue ]]; then min_blue=$blue; fi
        done <<< "$(echo $matches | each_match)"

        local power=$((min_red * min_green * min_blue))
        result=$((result + power))
    done <<< "$(each_game)"

    echo "part2: $result"
}

# ==============================================================================

if [[ $# -ne 2 ]]; then
    show_usage
fi

subcommand="$1"
input_file="$2"

case $subcommand in
"part1") part1;;
"part2") part2;;
*) show_usage;;
esac
