#!/bin/bash

# Jika file CSV tidak diberikan, coba gunakan default "pokemon_usage.csv"
if [ "$#" -lt 2 ]; then
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        COMMAND="$1"
    else
        FILE="pokemon_usage.csv"
        COMMAND="$1"
    fi
else
    FILE=$1
    COMMAND=$2
fi

# Cek apakah file CSV ada di direktori
if [ ! -f "$FILE" ]; then
    echo "Error: File $FILE tidak ditemukan!"
    exit 1
fi

case "$COMMAND" in
    --info)
        echo "Summary of $FILE"
        awk -F',' 'NR>1 {if($2>maxUsage){maxUsage=$2;nameUsage=$1} if($3>maxRaw){maxRaw=$3;nameRaw=$1}} END {printf "Highest Adjusted Usage: %s with %.5f%%\nHighest Raw Usage: %s with %d uses\n", nameUsage, maxUsage, nameRaw, maxRaw}' "$FILE"
        ;;
    
    --sort)
        if [ -z "$3" ]; then
            echo "Error: Harap tentukan kolom untuk diurutkan."
            exit 1
        fi
        column_name="$3"
        case "$column_name" in
            usage) column=2;;
            raw) column=3;;
            name) column=1;;
            hp) column=6;;
            atk) column=7;;
            def) column=8;;
            spatk) column=9;;
            spdef) column=10;;
            speed) column=11;;
            *) echo "Error: Kolom tidak valid!"; exit 1;;
        esac
        if [ "$column_name" == "name" ]; then
            sort -t',' -k$column "$FILE"
        else
            sort -t',' -k$column -nr "$FILE"
        fi
        ;;
    
    --grep)
        if [ -z "$3" ]; then
            echo "Error: Harap masukkan nama Pokémon yang dicari."
            exit 1
        fi
        grep -i "^$3," "$FILE" | sort -t',' -k2 -nr
        ;;
    
    --filter)
        if [ -z "$3" ]; then
            echo "Error: Harap masukkan tipe Pokémon yang dicari."
            exit 1
        fi
        awk -F',' -v type="$3" 'NR==1 || ($4 == type || $5 == type)' "$FILE" | sort -t',' -k2 -nr
        ;;
    
    -h|--help)
        echo "
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
            @@@@@
   
   POKÉMON ANALYSIS TOOL 
   ===============================
   Usage: ./pokemon_analysis.sh [file] [command] [option]
   Commands:
   --info             Menampilkan Pokémon dengan Usage% dan Raw Usage tertinggi
   --sort [kolom]     Mengurutkan berdasarkan kolom (usage, raw, name, hp, atk, def, spatk, spdef, speed)
   --grep [nama]      Mencari Pokémon berdasarkan nama
   --filter [tipe]    Mencari Pokémon berdasarkan tipe
   -h, --help         Menampilkan help screen
        "
        ;;
    
    *)
        echo "Error: Perintah tidak valid. Gunakan -h atau --help untuk panduan."
        exit 1
        ;;
esac
