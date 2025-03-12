#!/bin/bash

DB_FILE="/data/player.csv"
SALT="static_salt"

# Validasi jumlah parameter
if [[ $# -ne 3 ]]; then
    echo "Usage: $0 <email> <username> <password>"
    exit 1
fi

EMAIL=$1
USERNAME=$2
PASSWORD=$3

# Validasi email
if ! [[ "$EMAIL" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "Invalid email format!"
    exit 1
fi

# Validasi password (minimal 8 karakter, huruf kecil, huruf besar, angka)
if ! [[ "$PASSWORD" =~ [A-Z] && "$PASSWORD" =~ [a-z] && "$PASSWORD" =~ [0-9] && ${#PASSWORD} -ge 8 ]]; then
    echo "Password must be at least 8 characters long and include a number, uppercase, and lowercase letter."
    exit 1
fi

# Cek apakah email sudah terdaftar
if grep -q "^$EMAIL," "$DB_FILE"; then
    echo "Email already registered!"
    exit 1
fi

# Hash password dengan SHA256 + salt
HASHED_PASSWORD=$(echo -n "$PASSWORD$SALT" | sha256sum | awk '{print $1}')

# Simpan ke database
echo "$EMAIL,$USERNAME,$HASHED_PASSWORD" >> "$DB_FILE"
echo "Registration successful!"
