#!/bin/bash

# Cek apakah file CSV ada
CSV_FILE="pokemon_usage.csv"

if [[ ! -f "$CSV_FILE" ]]; then
    echo "Error: File $CSV_FILE tidak ditemukan!"
    exit 1
fi

# Fungsi untuk menampilkan ringkasan data
function show_info() {
    echo "Summary of $CSV_FILE"

    # Cari Pokémon dengan Usage% n
    highest_usage=$(awk -F',' 'NR>1 {if($2>max){max=$2;name=$1}} END{print name, max}' "$CSV_FILE")
    echo "Highest Adjusted Usage: $highest_usage%"

    # Cari Pokémon dengan RawUsage tertinggi
    highest_raw=$(awk -F',' 'NR>1 {if($3>max){max=$3;name=$1}} END{print name, max}' "$CSV_FILE")
    echo "Highest Raw Usage: $highest_raw uses"
}

# Fungsi untuk mengurutkan berdasarkan kolom
function sort_data() {
    COLUMN=$1
    case $COLUMN in
        usage) SORT_COL=2 ;;
        rawusage) SORT_COL=3 ;;
        name) SORT_COL=1 ;;
        hp) SORT_COL=6 ;;
        atk) SORT_COL=7 ;;
        def) SORT_COL=8 ;;
        spatk) SORT_COL=9 ;;
        spdef) SORT_COL=10 ;;
        speed) SORT_COL=11 ;;
        *)
            echo "Error: Kolom tidak valid!"
            exit 1
            ;;
    esac

    echo "Mengurutkan berdasarkan $COLUMN:"
    head -n 1 "$CSV_FILE"
    tail -n +2 "$CSV_FILE" | sort -t ',' -k"$SORT_COL" -r
}

# Fungsi untuk mencari Pokémon berdasarkan nama
function search_pokemon() {
    NAME=$1
    echo "Mencari Pokémon dengan nama: $NAME"
    grep -i "^$NAME," "$CSV_FILE"
}

# Fungsi untuk mencari Pokémon berdasarkan tipe
function filter_pokemon() {
    TYPE=$1
    echo "Mencari Pokémon dengan tipe: $TYPE"
    head -n 1 "$CSV_FILE"
    awk -F',' -v type="$TYPE" 'NR==1 || $4 == type || $5 == type' "$CSV_FILE"
}

# Fungsi untuk menampilkan help screen dengan ASCII art
function show_help() {
    cat <<EOF
                                                  @@%                                         
                                                @@%*#%%                                       
                                              %%%#--=#%%                                      
           @%%%%%               %%%%%@%%%    %%%==*%%%        %%%%%%%%                        
     @%%%%%######%%%%      @@%%%#*+%%@%*%%% @@@%%%%%%%% @@%####%%===#%     @@%%%%#            
  @%%%*=----------=*%%%   @@@%==--=#%*--=+%%%%#+=--=+*%%@%%----##---*%%    @@%++**###%@###    
@@@%----------------+%%   @%%@%*---#=-----#%*---###=--+%%%+----+*---=%%    @@%%+---=##%#+**###
@@@%%--------=%%%%---*%% %%%@@%#--------*%%#--*% %*--%%@@%-----=----=#%%%%###%%=----*##----*##
  @@@%#%=-----#@#%#--%%%%*==+*%%------+%% %*--+%%--#%**%%#-----------%%-=%=--=+%+---+#*---=## 
   %%%@@%=----=%%%--#%#-=%=----*%-----=+#%%%=----------=#%#--+-----=%*-+%%=-*+-*#----#=---##  
      @@%%-----+--=%%*--#%%#*#-=##--=-----=#%#-------=#%%=---##--%-*%--=*%%%+--*#-+--=---*##  
       @@@%-----*%%@%=--=+##*--=%*-=%%%#=---=*%%%%%%%@@%%---=%%#*%++%=--------+#=-#-----=##   
       @@@%#----+%@@%+---------%#--=%@@@@%%*=---*%@  @@%%%%%#%@%%%*=*%+-----=##--=#-----##%   
        @@@%*---=#%@@%#-----=#%%#--=%%  @@@@@%%**%%    @@@@@@@@@@%#--=*%%%%@@#---*#----+##    
         @@@%+---+%%@@@@%%%%@@@@%%%%%%      @@@@@%%            @@@@@%%%%%%@@@%%####---=##     
          @@@%=--=%%% @@@@@  @@@@@             @@@                 @@@@@@  @@@@@@@#---*#%     
           @@@%%%%%@@                                                          @@@@%###%@@    
            @@@@@                                                                  @@@@          
Command:
  --info         : Menampilkan ringkasan data
  --sort <kolom> : Mengurutkan data berdasarkan kolom (usage, rawusage, name, hp, atk, def, spatk, spdef, speed)
  --grep <nama>  : Mencari Pokémon berdasarkan nama
  --filter <tipe>: Mencari Pokémon berdasarkan tipe
  -h, --help     : Menampilkan help screen
EOF
}

# **Parsing Argument**
case $1 in
    --info)
        show_info
        ;;
    --sort)
        if [[ -z $2 ]]; then
            echo "Error: Harus memasukkan kolom untuk sorting!"
            exit 1
        fi
        sort_data "$2"
        ;;
    --grep)
        if [[ -z $2 ]]; then
            echo "Error: Harus memasukkan nama Pokémon!"
            exit 1
        fi
        search_pokemon "$2"
        ;;
    --filter)
        if [[ -z $2 ]]; then
            echo "Error: Harus memasukkan tipe Pokémon!"
            exit 1
        fi
        filter_pokemon "$2"
        ;;
    -h|--help)
        show_help
        ;;
    *)
        echo "Error: Perintah tidak dikenali!"
        echo "Gunakan -h atau --help untuk melihat daftar perintah."
        exit 1
        ;;
esac
