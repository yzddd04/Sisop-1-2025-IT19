#!/bin/bash

FILE="reading_data.csv"

if [[ ! -f "$FILE" ]]; then
    echo "File $FILE tidak ditemukan!"
    exit 1
fi

# a. Menghitung jumlah buku yang dibaca oleh Chris Hemsworth
if [[ "$1" == "1a" ]]; then
    count=$(awk -F',' '$2 ~ /Chris Hemsworth/ {count++} END {print count}' "$FILE")
    echo "Chris Hemsworth membaca $count buku."
fi

# b. Menghitung rata-rata durasi membaca dengan Tablet
if [[ "$1" == "1b" ]]; then
    avg=$(awk -F',' '$8 ~ /Tablet/ {sum+=$7; count++} END {if (count > 0) print sum/count; else print 0}' "$FILE")
    printf "Rata-rata durasi membaca dengan Tablet adalah %.2f menit.\n" "$avg"
fi

# c. Mencari pembaca dengan rating tertinggi beserta buku yang dibaca
if [[ "$1" == "1c" ]]; then
    highest=$(awk -F',' 'NR==1{next} {if($8 > max) {max=$8; name=$2; book=$3}} END {print name " - " book " - " max}' "$FILE")
    echo "Pembaca dengan rating tertinggi: $highest"
fi

# d. Mencari genre paling populer di Asia setelah 31 Desember 2023
if [[ "$1" == "1d" ]]; then
    genre=$(awk -F',' '$9 ~ /Asia/ && $6 > "2023-12-31" {count[$4]++} END {for (g in count) if (count[g] > max) {max=count[g]; pop_genre=g} print pop_genre, max}' "$FILE")
    echo "Genre paling populer di Asia setelah 2023 adalah $genre buku."
fi
