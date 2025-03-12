#!/bin/bash

DB_FILE="/data/player.csv"
SALT="static_salt"

# Validasi jumlah parameter
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <email> <password>"
    exit 1
fi

EMAIL=$1
PASSWORD=$2

# Hash password untuk perbandingan
HASHED_PASSWORD=$(echo -n "$PASSWORD$SALT" | sha256sum | awk '{print $1}')

# Validasi login
if grep -q "^$EMAIL,.*,$HASHED_PASSWORD$" "$DB_FILE"; then
    echo "Login successful!"
else
    echo "Invalid email or password!"
    exit 1
fi
