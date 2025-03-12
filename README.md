# Praktikum Sisop IT19

## Anggota Kelompok
1. Ahmad Yazid Arifuddin - 5027241040
2. Muhammad Ziddan Habibi - 5027241122
3. Andi Naufal Zaki - 5027241059

### Deskripsi No. 1
Program ini merupakan implementasi dari soal 1 pada praktikum sistem operasi, yang bertujuan untuk menganalisis data dari file `reading_data.csv` menggunakan script Bash dan perintah `awk`.

## Penjelasan No. 1
Script Bash `poppo_siroyo.sh` memiliki beberapa fungsi utama untuk menjawab pertanyaan berdasarkan data dalam `reading_data.csv`.

### 1a: Menghitung Jumlah Buku yang Dibaca oleh Chris Hemsworth
Menampilkan jumlah buku yang telah dibaca oleh Chris Hemsworth dengan menggunakan `awk` untuk memfilter berdasarkan nama.

**Command:**
```bash
./poppo_siroyo.sh 1a
```
**Output Contoh:**
```
Chris Hemsworth membaca 2 buku.
```

### 1b: Menghitung Rata-rata Durasi Membaca dengan Tablet
Menghitung rata-rata durasi membaca (Reading_Duration_Minutes) untuk buku yang dibaca menggunakan "Tablet".

**Command:**
```bash
./poppo_siroyo.sh 1b
```
**Output Contoh:**
```
Rata-rata durasi membaca dengan Tablet adalah 60.5 menit.
```

### 1c: Mencari Pembaca dengan Rating Tertinggi
Menampilkan nama pembaca, judul buku, dan rating tertinggi berdasarkan data dalam `reading_data.csv`.

**Command:**
```bash
./poppo_siroyo.sh 1c
```
**Output Contoh:**
```
Pembaca dengan rating tertinggi: Brie Larson - Business Strategies - 4.7
```

### 1d: Mencari Genre Paling Populer di Asia Setelah 31 Desember 2023
Menampilkan genre yang paling banyak dibaca di Asia setelah tanggal 31 Desember 2023.

**Command:**
```bash
./poppo_siroyo.sh 1d
```
**Output Contoh:**
```
Genre paling populer di Asia setelah 2023 adalah Science dengan 1 buku.
```

## Cara Menjalankan Script
1. Pastikan script memiliki izin eksekusi:
   ```bash
   chmod +x poppo_siroyo.sh
   ```
2. Jalankan script dengan argumen sesuai kebutuhan, misalnya:
   ```bash
   ./poppo_siroyo.sh 1a
   ```

## Dependencies
- Bash
- AWK

## Kesimpulan
Script `poppo_siroyo.sh` mampu menganalisis data membaca dari `reading_data.csv` dan memberikan informasi yang dibutuhkan sesuai dengan soal yang diberikan dalam praktikum sistem operasi.








































### Deskripsi No. 4
Program ini merupakan implementasi dari soal nomor 4 pada praktikum sistem operasi yang bertujuan untuk menganalisis data dari file `pokemon_usage.csv` menggunakan script Bash dan perintah `awk`.

## Penjelasan Script No. 4
Script Bash `pokemon_analysis.sh` memiliki beberapa fungsi utama untuk menganalisis data dalam `pokemon_usage.csv`.

### 1. Menampilkan Ringkasan Data
Menampilkan Pokémon dengan Usage% dan RawUsage tertinggi.

**Command:**
```bash
./pokemon_analysis.sh --info
```
**Output Contoh:**
```
Summary of pokemon_usage.csv
Highest Adjusted Usage: Pikachu 31.09%
Highest Raw Usage: Charizard 563831 uses
```

### 2. Mengurutkan Data Berdasarkan Kolom Tertentu
Mengurutkan data Pokémon berdasarkan salah satu dari kolom berikut:
- `usage`
- `rawusage`
- `name`
- `hp`
- `atk`
- `def`
- `spatk`
- `spdef`
- `speed`

**Command:**
```bash
./pokemon_analysis.sh --sort usage
```
**Output Contoh:**
```
Mengurutkan berdasarkan usage:
Pokemon,Usage%,RawUsage,Type1,Type2,HP,Atk,Def,SpAtk,SpDef,Speed
Pikachu,31.09%,253499,Electric,None,75,95,125,45,75,95
Charizard,27.06%,563831,Fire,Flying,115,131,131,53,53,87
```

### 3. Mencari Pokémon Berdasarkan Nama
Menampilkan data Pokémon yang sesuai dengan nama yang dicari.

**Command:**
```bash
./pokemon_analysis.sh --grep pikachu
```
**Output Contoh:**
```
Mencari Pokémon dengan nama: Pikachu
Pikachu,31.09%,253499,Electric,None,75,95,125,45,75,95
```

### 4. Mencari Pokémon Berdasarkan Tipe
Menampilkan semua Pokémon dengan tipe tertentu.

**Command:**
```bash
./pokemon_analysis.sh --filter electric
```
**Output Contoh:**
```
Mencari Pokémon dengan tipe: Electric
Pokemon,Usage%,RawUsage,Type1,Type2,HP,Atk,Def,SpAtk,SpDef,Speed
Pikachu,31.09%,253499,Electric,None,75,95,125,45,75,95
Zapdos,10.5%,120000,Electric,Flying,90,90,85,125,90,100
```

### 5. Menampilkan Help Screen
Menampilkan bantuan dengan ASCII art dan daftar perintah yang tersedia.

**Command:**
```bash
./pokemon_analysis.sh --help
```

## Cara Menjalankan Script
1. Pastikan script memiliki izin eksekusi:
   ```bash
   chmod +x pokemon_analysis.sh
   ```
2. Jalankan script dengan argumen sesuai kebutuhan, misalnya:
   ```bash
   ./pokemon_analysis.sh --info
   ```

## Dependencies
- Bash
- AWK

## Kesimpulan
Script `pokemon_analysis.sh` mampu menganalisis data Pokémon berdasarkan berbagai parameter, membantu dalam memilih Pokémon terbaik untuk bertarung dalam kompetisi.

