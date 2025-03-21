#!/bin/bash

FILE="reading_data.csv"

if [[ ! -f "$FILE" ]]; then
    echo "File $FILE tidak ditemukan!"
    exit 1
fi

echo "Pilih opsi soal yang ingin dijalankan:"
echo "1a - Menghitung jumlah buku yang dibaca oleh Chris Hemsworth"
echo "1b - Menghitung rata-rata durasi membaca dengan Tablet"
echo "1c - Mencari pembaca dengan rating tertinggi beserta buku yang dibaca"
echo "1d - Mencari genre paling populer di Asia setelah 31 Desember 2023"
read -p "Masukkan pilihan (1a/1b/1c/1d): " choice #p = prompt

if [[ "$choice" == "1a" ]]; then
    count=$(awk -F',' '$2 ~ /Chris Hemsworth/ {count++} END {print count}' "$FILE") #$2 = kolom ke 2
    echo "Chris Hemsworth membaca $count buku."

elif [[ "$choice" == "1b" ]]; then
    avg=$(awk -F',' '$8 ~ /Tablet/ {sum+=$6; count++} END {if (count > 0) print sum/count; else print 0}' "$FILE")
    printf "Rata-rata durasi membaca dengan Tablet adalah %.2f menit.\n" "$avg"

elif [[ "$choice" == "1c" ]]; then
    highest=$(awk -F',' 'NR==1{next} {if($7 > max) {max=$7; name=$2; book=$3}} END {print name " - " book " - " max}' "$FILE") # number of
    echo "Pembaca dengan rating tertinggi: $highest"

elif [[ "$choice" == "1d" ]]; then
    genre=$(awk -F',' '$9 ~ /Asia/ && $5 > "2023-12-31" {count[$4]++} END {for (g in count) if (count[g] > max) {max=count[g]; pop_genre=g} print pop_genre, max}' "$FILE")
    genre_name=$(echo "$genre" | awk '{print $1}')
    genre_count=$(echo "$genre" | awk '{print $2}')
    echo "Genre paling populer di Asia setelah 2023 adalah $genre_name dengan $genre_count buku."
    
else
    echo "Pilihan tidak valid! Silakan pilih 1a, 1b, 1c, atau 1d."
    exit 1
fi
