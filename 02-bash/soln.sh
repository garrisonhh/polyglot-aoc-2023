#! /usr/bin/env bash

function error_exit() {
    msg="$1"
    >&2 echo "error: $msg"
    exit -1
}

function show_usage() {
    error_exit "usage: $0 (part1|part2) <input-file.txt>"
}

# iterates over games. you can read output with:
# `each_game | while read -r gameno matches`
function each_game() {
    cat $input_file \
        | sed -E 's/^Game ([0-9]+): (.+)$/\1 '\''\2\'\''/g'
}

# iterates through matches from each_game. read output with:
# `echo $matches | each_match | while read -r red green blue`
function each_match() {
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

function part1() {
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

function part2() {
    error_exit "TODO part2"
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
