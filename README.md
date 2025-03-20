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

```bash
speak_to_me(){
    clear
    for i in {1..10}; do
        curl -s "https://www.affirmations.dev" | jq -r '.affirmation'
        sleep 1
    done
}
```

Fungsi ini bertujuan untuk menampilkan sepuluh kutipan motivasi yang diambil dari situs https://www.affirmations.dev. Saat fungsi ini dijalankan, pertama-tama layar akan dibersihkan dengan perintah ```clear```. Kemudian, dalam sebuah loop yang berjalan sebanyak sepuluh kali ```(for i in {1..10}; do)```, skrip akan menggunakan ```curl -s``` untuk mengambil data dari API situs tersebut, lalu memprosesnya menggunakan ```jq -r '.affirmation' ```agar hanya teks afirmasi yang ditampilkan. Setelah setiap kutipan ditampilkan, skrip akan menunggu selama satu detik ```(sleep 1)``` sebelum mengambil kutipan berikutnya. Hal ini memberikan efek seolah-olah pengguna sedang membaca kutipan satu per satu dalam interval waktu tertentu.
out put yang akan muncul :

![image](https://github.com/user-attachments/assets/19359b7a-b2b9-4568-a762-b3704eeee948)


### Case 2 ( on the run )

```bash
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
```
Fungsi ini menampilkan progres bar sederhana yang menunjukkan persentase kemajuan dari 0% hingga 100%. Di dalam fungsi ini, terdapat fungsi internal bernama ProgressBar, yang bertanggung jawab untuk menghitung dan mencetak progres berdasarkan dua parameter: nilai saat ini ```($1)``` dan nilai akhir ```($2)```. Fungsi ini menggunakan perhitungan matematika ```let _progress=(${1}*100/${2}*100)/100``` untuk menghitung persentase kemajuan, lalu menentukan berapa banyak karakter # yang harus ditampilkan dalam progress bar. Di dalam perulangan ```for number in $(seq ${_start} ${_end}); do```, nilai number akan bertambah dari 1 hingga 100, dan setiap iterasi akan memperbarui progress bar. Untuk memberikan efek visual yang lebih dinamis, waktu tidur antar iterasi ditentukan secara acak menggunakan ```awk -v min=0.1 -v max=1 'BEGIN{srand(); print min+rand()*(max-min)}'```, yang memberikan jeda waktu antara 0.1 hingga 1 detik. Setelah progres mencapai 100%, skrip mencetak pesan``` "Finished!" ```untuk menandakan bahwa proses telah selesai.


![image](https://github.com/user-attachments/assets/bb21659c-44c7-441b-90f4-1be8097cf482)

### Case 3 ( Time )

```bash
Time(){
    while true; do
        clear
        date "+%d:%m:%y  %H:%M:%S"
        sleep 1
    done
}
```
Fungsi Time dirancang untuk menampilkan waktu saat ini yang diperbarui setiap detik. Dalam perulangan ```while true; do```, skrip akan terus membersihkan layar ```(clear)``` dan mencetak waktu saat ini menggunakan perintah date ```"+%d:%m:%y %H:%M:%S"```. Format yang digunakan menampilkan tanggal dalam format dd:mm:yy dan waktu dalam format HH:MM:SS. Setelah mencetak waktu, skrip akan berhenti sejenak selama satu detik dengan ```sleep 1``` sebelum mengulang kembali perulangan, sehingga pengguna dapat melihat waktu berjalan secara real-time.


![image](https://github.com/user-attachments/assets/be8becdf-1705-4090-8095-741c0128e06b)

### Case 4 ( Money )
```bash
money(){
### Kustomisasi warna
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

warnaterpilih=($abu $biruterang $merahterang $cyanterang)

jarak=${1:-100}
pergeseran=${2:-0}
barislayar=$(expr `tput lines` - 1 + $pergeseran)
kolomlayar=$(expr `tput cols` / 2 - 1)

karakter=("$" "€" "£" "¥" "¢" "₹" "₩" "₿" "₣")

jumlahkarakter=${#karakter[@]}
jumlahwarna=${#warnaterpilih[@]}

trap "tput sgr0; clear; exit" SIGTERM SIGINT

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
done
tput cup 0 0
done
}
```

Fungsi ini menciptakan efek visual hujan mata uang seperti efek "The Matrix" di terminal. Pertama, skrip mendefinisikan berbagai kode warna ANSI untuk menghasilkan tampilan warna-warni. Warna-warna ini disimpan dalam array warnaterpilih, yang kemudian digunakan secara acak. Skrip juga mendefinisikan array karakter, yang berisi simbol mata uang seperti ```$, €, £, ¥, ₹,``` dan sebagainya.
Setelah semua variabel diatur, skrip mulai menampilkan efek dengan perulangan ```while :``` yang berjalan selamanya. Di dalamnya, ada dua perulangan bersarang: yang pertama untuk iterasi baris ```(for i in $(eval echo {1..$barislayar}))```, dan yang kedua untuk iterasi kolom ```(for i in $(eval echo {1..$kolomlayar}))```. Setiap iterasi akan secara acak memilih apakah mencetak simbol mata uang atau hanya spasi kosong ```(printf " ")```, sehingga efek hujan terlihat lebih acak dan alami. Ketika terminal mencapai bagian paling bawah, skrip akan mengembalikan kursor ke posisi awal ```(tput cup 0 0)```, menciptakan ilusi bahwa karakter terus mengalir dari atas ke bawah.


![image](https://github.com/user-attachments/assets/7ead542a-62e1-44ff-94a4-5aa5d38788c8)


### Case 5 ( Brain Damage )
```bash
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
```
Fungsi ini bertindak seperti "Task Manager" yang menunjukkan daftar proses yang berjalan dalam sistem. Skrip ini menggunakan perintah ```ps -eo pid,user,%cpu,%mem,cmd --sort=-%cpu```, yang mengambil daftar proses yang sedang berjalan, lalu mengurutkannya berdasarkan penggunaan CPU tertinggi ```(--sort=-%cpu)```. Kemudian, ```awk``` digunakan untuk memformat output sehingga hanya 20 proses pertama yang ditampilkan. Dalam perulangan ```while true; do```, skrip akan terus membersihkan layar ```(clear)```, mencetak header tabel dengan ```printf```, lalu menampilkan daftar proses yang diperbarui setiap satu detik ```(sleep 1)```.






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




