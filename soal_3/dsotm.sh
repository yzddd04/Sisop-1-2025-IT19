#!/bin/bash

# Parsing agar bisa pake --play
RUN=""

for arg in "$@"; do
    case $arg in
        --play=*)
            RUN="${arg#*=}"
            ;;
    esac
done


if [[ -z "$RUN" ]]; then
    echo "Usage: ./dsotm.sh --play=\"<RUN>\""
    echo "Available runs: speak to me, on the run, Time, Money, Brain Damage"
    exit 1
fi


speak_to_me(){
    for i in {1..10}; do
        curl -s "https://www.affirmations.dev" | jq -r '.affirmation'
        sleep 1
    done
}

on_the_run(){
    function ProgressBar {
        let _progress=(${1}*100/${2}*100)/100
        let _done=(${_progress}*4)/10
        let _left=40-$_done
        _fill=$(printf "%${_done}s")
        _empty=$(printf "%${_left}s")
        printf "\rProgress : [${_fill// /#}${_empty// /-}] ${_progress}%%"
    }

    _start=1
    _end=100
    for number in $(seq ${_start} ${_end}); do
        sleep $(awk -v min=0.1 -v max=1 'BEGIN{srand(); print min+rand()*(max-min)}')
        ProgressBar ${number} ${_end}
    done
    printf '\nFinished!\n'
}

Time(){
    while true; do
        clear
        date "+%d:%m:%y  %H:%M:%S"
        sleep 1
    done
}

money(){
cmatrix -u 3 -r
}

Brain_damage(){
    ps aux
}

case "$RUN" in
    "speak to me")
        speak_to_me
        ;;
    "on the run")
        on_the_run
        ;;
    "Time")
        Time
        ;;
    "Money")
        money
        ;;
    "Brain Damage")
        Brain_damage
        ;;
    *)
        echo "Usage: ./dsotm.sh --play=\"<RUN>\""
        echo "Available runs: speak to me, on the run, Time, Money, Brain Damage"
        ;;
esac
