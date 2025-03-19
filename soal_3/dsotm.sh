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
    clear
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
    clear
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
### Kustomisasi:
biru="\033[0;34m"
biruterang="\033[1;34m"
cyan="\033[0;36m"
cyanterang="\033[1;36m"
hijau="\033[0;32m"
hijauterang="\033[1;32m"
merah="\033[0;31m"
merahterang="\033[1;31m"
putih="\033[1;37m"
hitam="\033[0;30m"
abu="\033[0;37m"
abugelap="\033[1;30m"

# Pilih warna yang akan digunakan dari daftar di atas
# Daftar warna dipisahkan dengan spasi
warnaterpilih=($abu $biruterang $merahterang $cyanterang)

jarak=${1:-100}
pergeseran=${2:-0} # 0 untuk statis, angka positif menentukan kecepatan pergeseran
barislayar=$(expr `tput lines` - 1 + $pergeseran)
kolomlayar=$(expr `tput cols` / 2 - 1)

# Karakter yang digunakan
karakter=("$" "€" "£" "¥" "¢" "₹" "₩" "₿" "₣")

jumlahkarakter=${#karakter[@]}
jumlahwarna=${#warnaterpilih[@]}

trap "tput sgr0; clear; exit" SIGTERM SIGINT

if [[ $1 =~ '-h' ]]; then
echo "Tampilkan efek Matrix di terminal"
echo "Penggunaan:    matrix [JARAK [PERGESERAN]]"
echo "Contoh:        matrix 100 0"
exit 0
fi

clear
tput cup 0 0
while :
do 
for i in $(eval echo {1..$barislayar})
do 
for i in $(eval echo {1..$kolomlayar})
do 
acak=$(($RANDOM%$jarak))
case $acak in
0)
printf "${warnaterpilih[$RANDOM%$jumlahwarna]}${karakter[$RANDOM%$jumlahkarakter]} "
;;
1)
printf "  "
;;
*)
printf "\033[2C"
;;
esac
done
printf "\n"

# jeda .005 detik
done
tput cup 0 0
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
