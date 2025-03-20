# README

## Anggota Kelompok
1. Ahmad Yazid Arifuddin - 5027241040 (no. 1 & 4)
2. Muhammad Ziddan Habibi -	5027241122 (no. 3)
3. Andi Naufal Zaki	- 5027241059 (no. 2)


## Soal NO 1 ( Ahmad Yazid Arifuddin - 5027241040 )
## Deskripsi
Skrip Bash ini digunakan untuk menganalisis data dari file CSV `reading_data.csv`. Skrip ini menawarkan beberapa opsi untuk mengambil informasi tertentu dari dataset, seperti jumlah buku yang dibaca oleh individu tertentu, rata-rata durasi membaca dengan perangkat tertentu, pembaca dengan rating tertinggi, dan genre paling populer dalam wilayah tertentu setelah tanggal tertentu.

## Prasyarat
- Sistem operasi berbasis UNIX/Linux dengan Bash
- File `reading_data.csv` harus tersedia dalam direktori yang sama dengan skrip
- File CSV harus memiliki format dengan kolom yang sesuai dengan operasi yang dilakukan dalam skrip

## Cara Penggunaan
1. Pastikan file `reading_data.csv` tersedia di direktori yang sama dengan skrip ini.
2. Jalankan skrip dengan perintah berikut:
   ```bash
   ./script.sh
   ```
3. Pilih salah satu opsi yang tersedia dengan memasukkan kode pilihan (1a, 1b, 1c, atau 1d):
   - **1a** - Menghitung jumlah buku yang dibaca oleh Chris Hemsworth
   - **1b** - Menghitung rata-rata durasi membaca dengan Tablet
   - **1c** - Mencari pembaca dengan rating tertinggi beserta buku yang dibaca
   - **1d** - Mencari genre paling populer di Asia setelah 31 Desember 2023
4. Skrip akan menampilkan hasil sesuai dengan pilihan yang dimasukkan.

## Penjelasan Logika Skrip
- Skrip terlebih dahulu memeriksa keberadaan file `reading_data.csv`. Jika tidak ditemukan, skrip akan berhenti dengan pesan kesalahan.
- Berdasarkan input pengguna, skrip akan menjalankan salah satu dari empat opsi:

### 1a - Menghitung jumlah buku yang dibaca oleh Chris Hemsworth
**Operasi yang dilakukan:**
- Menggunakan perintah `awk` untuk mencari semua baris dalam file CSV di mana kolom kedua (`$2`) berisi nama "Chris Hemsworth".
- Skrip menghitung jumlah kemunculan nama tersebut dalam dataset.

**Kode:**
```bash
awk -F',' '$2 ~ /Chris Hemsworth/ {count++} END {print count}' "$FILE"
```

**Contoh Input:**
```
Masukkan pilihan (1a/1b/1c/1d): 1a
```
**Contoh Output:**
```
Chris Hemsworth membaca 5 buku.
```

---
### 1b - Menghitung rata-rata durasi membaca dengan Tablet
**Operasi yang dilakukan:**
- Menggunakan `awk` untuk menjumlahkan semua durasi membaca (kolom ke-6, `$6`) bagi pembaca yang menggunakan "Tablet" (kolom ke-8, `$8`).
- Rata-rata dihitung dengan membagi jumlah total durasi dengan jumlah baris yang memenuhi syarat.

**Kode:**
```bash
awk -F',' '$8 ~ /Tablet/ {sum+=$6; count++} END {if (count > 0) print sum/count; else print 0}' "$FILE"
```

**Contoh Input:**
```
Masukkan pilihan (1a/1b/1c/1d): 1b
```
**Contoh Output:**
```
Rata-rata durasi membaca dengan Tablet adalah 42.75 menit.
```

---
### 1c - Mencari pembaca dengan rating tertinggi beserta buku yang dibaca
**Operasi yang dilakukan:**
- Menggunakan `awk` untuk mencari baris dengan nilai rating tertinggi (kolom ke-7, `$7`).
- Jika ditemukan rating tertinggi, skrip menyimpan nama pembaca (kolom ke-2, `$2`) dan judul buku yang dibaca (kolom ke-3, `$3`).

**Kode:**
```bash
awk -F',' 'NR==1{next} {if($7 > max) {max=$7; name=$2; book=$3}} END {print name " - " book " - " max}' "$FILE"
```

**Contoh Input:**
```
Masukkan pilihan (1a/1b/1c/1d): 1c
```
**Contoh Output:**
```
Pembaca dengan rating tertinggi: John Doe - "The Great Gatsby" - 5.0
```

---
### 1d - Mencari genre paling populer di Asia setelah 31 Desember 2023
**Operasi yang dilakukan:**
- Skrip mencari semua baris dalam file CSV di mana kolom ke-9 (`$9`) berisi "Asia" dan kolom ke-5 (`$5`) memiliki tanggal setelah "2023-12-31".
- Skrip kemudian menghitung frekuensi masing-masing genre (kolom ke-4, `$4`) dan menentukan genre dengan jumlah tertinggi.

**Kode:**
```bash
awk -F',' '$9 ~ /Asia/ && $5 > "2023-12-31" {count[$4]++} END {for (g in count) if (count[g] > max) {max=count[g]; pop_genre=g} print pop_genre, max}' "$FILE"
```

**Contoh Input:**
```
Masukkan pilihan (1a/1b/1c/1d): 1d
```
**Contoh Output:**
```
Genre paling populer di Asia setelah 2023 adalah Fiksi dengan 12 buku.
```

## Catatan
- Pastikan format CSV sesuai dengan urutan kolom yang digunakan dalam skrip agar hasilnya akurat.
- Format tanggal dalam file CSV harus dalam format `YYYY-MM-DD`.

# README

## Deskripsi
Skrip Bash ini digunakan untuk menganalisis data penggunaan Pokemon dari file CSV `pokemon_usage.csv`. Skrip ini memungkinkan pengguna untuk melihat ringkasan data, mengurutkan berdasarkan kolom tertentu, mencari Pokemon berdasarkan nama, serta memfilter berdasarkan tipe.

## Prasyarat
- Sistem operasi berbasis UNIX/Linux dengan Bash.
- File `pokemon_usage.csv` harus tersedia dalam direktori yang sama dengan skrip.
- File CSV harus memiliki format dengan kolom yang sesuai dengan operasi yang dilakukan dalam skrip.

## Cara Penggunaan
1. Pastikan file `pokemon_usage.csv` tersedia di direktori yang sama dengan skrip ini.
2. Jalankan skrip dengan perintah berikut:
   ```bash
   ./pokemon_analysis.sh [file] [command] [option]
   ```
3. Pilih salah satu perintah yang tersedia:
   - `--info` : Menampilkan ringkasan data.
   - `--sort [kolom]` : Mengurutkan Pokemon berdasarkan kolom tertentu (usage, raw, name, hp, atk, def, spatk, spdef, speed).
   - `--grep [nama]` : Mencari Pokemon berdasarkan nama.
   - `--filter [tipe]` : Mencari Pokemon berdasarkan tipe.
   - `-h` atau `--help` : Menampilkan bantuan.


## Soal No 3 ( Muhammad Ziddan Habibi - 5027241122 )
### Case 1 ( speak to me )

speak_to_me(){
    clear
    for i in {1..10}; do
        curl -s "https://www.affirmations.dev" | jq -r '.affirmation'
        sleep 1
    done
}
Fungsi ini bertujuan untuk menampilkan sepuluh kutipan motivasi yang diambil dari situs https://www.affirmations.dev. Saat fungsi ini dijalankan, pertama-tama layar akan dibersihkan dengan perintah clear. Kemudian, dalam sebuah loop yang berjalan sebanyak sepuluh kali (for i in {1..10}; do), skrip akan menggunakan curl -s untuk mengambil data dari API situs tersebut, lalu memprosesnya menggunakan jq -r '.affirmation' agar hanya teks afirmasi yang ditampilkan. Setelah setiap kutipan ditampilkan, skrip akan menunggu selama satu detik (sleep 1) sebelum mengambil kutipan berikutnya. Hal ini memberikan efek seolah-olah pengguna sedang membaca kutipan satu per satu dalam interval waktu tertentu.
out put yang akan muncul :

![image](https://github.com/user-attachments/assets/19359b7a-b2b9-4568-a762-b3704eeee948)



## Soal NO 4 ( Ahmad Yazid Arifuddin - 5027241040 )
### 1. Melihat Ringkasan Data (`--info`)
**Operasi yang dilakukan:**
- Menggunakan `awk` untuk mencari Pokemon dengan penggunaan tertinggi berdasarkan kolom `Usage%` dan `Raw Usage`.

**Kode:**
```bash
awk -F',' 'NR>1 {if($2>maxUsage){maxUsage=$2;nameUsage=$1} if($3>maxRaw){maxRaw=$3;nameRaw=$1}} END {printf "Highest Adjusted Usage: %s with %.5f%%\nHighest Raw Usage: %s with %d uses\n", nameUsage, maxUsage, nameRaw, maxRaw}' "$FILE"
```

**Contoh Input:**
```bash
./pokemon_analysis.sh pokemon_usage.csv --info
```
**Contoh Output:**
```
Highest Adjusted Usage: Pikachu with 25.67345%
Highest Raw Usage: Charizard with 3450 uses
```

---
### 2. Mengurutkan Pokemon (`--sort [kolom]`)
**Operasi yang dilakukan:**
- Menggunakan `sort` untuk mengurutkan Pokemon berdasarkan kolom yang dipilih.

**Kode:**
```bash
sort -t',' -k$column -nr "$FILE"
```

**Contoh Input:**
```bash
./pokemon_analysis.sh pokemon_usage.csv --sort usage
```
**Contoh Output:**
```
Pokemon dengan penggunaan tertinggi ditampilkan secara berurutan.
```

---
### 3. Mencari Pokemon berdasarkan Nama (`--grep [nama]`)
**Operasi yang dilakukan:**
- Menggunakan `grep` untuk mencari Pokemon berdasarkan nama yang diberikan.
- Menggunakan `sort` untuk mengurutkan hasil berdasarkan `Usage%`.

**Kode:**
```bash
grep -i "^$3," "$FILE" | sort -t',' -k2 -nr
```

**Contoh Input:**
```bash
./pokemon_analysis.sh pokemon_usage.csv --grep Pikachu
```
**Contoh Output:**
```
Pikachu, 25.67345, 2000, Electric, -
```

---
### 4. Memfilter Pokemon berdasarkan Tipe (`--filter [tipe]`)
**Operasi yang dilakukan:**
- Menggunakan `awk` untuk memfilter Pokemon berdasarkan tipe yang dipilih.
- Menggunakan `sort` untuk mengurutkan berdasarkan `Usage%`.

**Kode:**
```bash
awk -F',' -v type="$3" 'NR==1 || ($4 == type || $5 == type)' "$FILE" | sort -t',' -k2 -nr
```

**Contoh Input:**
```bash
./pokemon_analysis.sh pokemon_usage.csv --filter Fire
```
**Contoh Output:**
```
Charizard, 20.12345, 3450, Fire, Flying
Blaziken, 15.98765, 2100, Fire, Fighting
```

---
### 5. Menampilkan Bantuan (`-h` atau `--help`)
**Operasi yang dilakukan:**
- Menampilkan petunjuk penggunaan skrip dengan daftar perintah yang tersedia.

**Contoh Input:**
```bash
./pokemon_analysis.sh -h
```
**Contoh Output:**
```
POKÉMON ANALYSIS TOOL
===============================
Usage: ./pokemon_analysis.sh [file] [command] [option]
Commands:
--info             Menampilkan Pokemon dengan Usage% dan Raw Usage tertinggi.
--sort [kolom]     Mengurutkan berdasarkan kolom (usage, raw, name, hp, atk, def, spatk, spdef, speed).
--grep [nama]      Mencari Pokemon berdasarkan nama.
--filter [tipe]    Mencari Pokemon berdasarkan tipe.
-h, --help         Menampilkan help screen.
```

## Catatan
- Pastikan format CSV sesuai dengan urutan kolom yang digunakan dalam skrip agar hasilnya akurat.
- Format file CSV harus sesuai dengan yang diharapkan agar skrip dapat berjalan dengan baik.




