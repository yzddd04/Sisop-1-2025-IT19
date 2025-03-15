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

#menunjukan apabila argumen yang salah maka menunjukan cara Nge Run yang benar
if [[ -z "$RUN" ]]; then
    echo "Usage: ./dsotm.sh --play=\"<RUN>\""
    echo "Available runs: speak to me, on the run, Time, Money, Brain Damage"
    exit 1
fi

#case pertama 
speak_to_me(){
    for i in {1..10}; do
        curl -s "https://www.affirmations.dev" | jq -r '.affirmation'
        sleep 1
    done
}
#case kedua
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
#case ketiga
Time(){
    while true; do
        clear
        date "+%d:%m:%y  %H:%M:%S"
        sleep 1
    done
}
#case ke empat
money(){
symbols=("$" "€" "£" "¥" "¢" "₹" "₩" "₿" "₣")
cols=$(tput cols)
rows=$(tput lines)

declare -A positions

while true; do
    for ((i=0; i<$cols; i++)); do
        if (( RANDOM % 10 < 2 )); then
            positions[$i]=$(( (positions[$i] + 1) % rows ))
            tput cup ${positions[$i]} $i
            echo -ne "\033[32m${symbols[RANDOM % ${#symbols[@]}]}\033[0m"
        fi
    done
    sleep 0.1
done
}
#case kelima
Brain_damage(){
while true; do
    clear
    echo "Task Manager - Brain Damage Edition"
    echo "------------------------------------------------------------"
    printf "%-8s %-10s %-5s %-5s %-s\n" "PID" "USER" "%CPU" "%MEM" "COMMAND"
    echo "------------------------------------------------------------"
    ps -eo pid,user,%cpu,%mem,cmd --sort=-%cpu | awk 'NR==1 || NR<=20 {printf "%-8s %-10s %-5s %-5s %-s\n", $1, $2, $3, $4, $5}'
    sleep 1
done
}

#agar dapat memilih satu fungsi yang ingin dijalankan dengan cara --play"nama fungsi(ex:Time)"
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
    #jika salah nama fungsinya menunjukan nama fungsi yang benarnya
        echo "Usage: ./dsotm.sh --play=\"<RUN>\""
        echo "Available runs: speak to me, on the run, Time, Money, Brain Damage"
        ;;
esac
