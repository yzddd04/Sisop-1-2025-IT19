#!/bin/bash

# Pastikan file CSV tersedia
FILE="reading_data.csv"

if [[ ! -f "$FILE" ]]; then
    echo "File reading_data.csv tidak ditemukan. Silakan unduh terlebih dahulu."
    exit 1
fi

awk -F',' '
BEGIN {
    chris_count = 0;
    total_duration = 0;
    tablet_count = 0;
    highest_rating = 0;
    top_reader = "";
    top_book = "";
}

NR > 1 {
    name = $1;
    book_title = $2;
    genre = $3;
    device = $4;
    rating = $5;
    duration = $6;
    region = $7;
    date = $8;

    # a. Hitung jumlah buku yang dibaca oleh Chris Hemsworth
    if (name == "Chris Hemsworth") {
        chris_count++;
    }

    # b. Hitung rata-rata durasi membaca dengan Tablet
    if (device == "Tablet") {
        total_duration += duration;
        tablet_count++;
    }

    # c. Cari pembaca dengan rating tertinggi
    if (rating > highest_rating) {
        highest_rating = rating;
        top_reader = name;
        top_book = book_title;
    }

    # d. Temukan genre paling populer di Asia setelah 31 Desember 2023
    if (region == "Asia" && date > "2023-12-31") {
        genre_count[genre]++;
    }
}

END {
    print "Chris Hemsworth membaca " chris_count " buku.";

    if (tablet_count > 0) {
        avg_duration = total_duration / tablet_count;
        print "Rata-rata durasi membaca dengan Tablet adalah " avg_duration " menit.";
    } else {
        print "Tidak ada data membaca dengan Tablet.";
    }

    print "Pembaca dengan rating tertinggi: " top_reader " - " top_book " - " highest_rating;

    max_genre = "";
    max_count = 0;
    for (g in genre_count) {
        if (genre_count[g] > max_count) {
            max_count = genre_count[g];
            max_genre = g;
        }
    }

    if (max_genre != "") {
        print "Genre paling populer di Asia setelah 2023 adalah " max_genre " dengan " max_count " buku.";
    } else {
        print "Tidak ada data genre di Asia setelah 2023.";
    }
}' "$FILE"
