#!/bin/bash

while true; do
    echo "=============================="
    echo "      Welcome to Arcaea       "
    echo "=============================="
    echo "1. Register"
    echo "2. Login"
    echo "3. Manage Crontab (CPU & RAM)"
    echo "4. Exit"
    echo "=============================="
    read -p "Choose an option: " choice

    case $choice in
        1)
            read -p "Enter email: " email
            read -p "Enter username: " username
            read -s -p "Enter password: " password
            echo
            bash register.sh "$email" "$username" "$password"
            ;;
        2)
            read -p "Enter email: " email
            read -s -p "Enter password: " password
            echo
            bash login.sh "$email" "$password"
            ;;
        3)
            bash scripts/manager.sh
            ;;
        4)
            exit 0
            ;;
        *)
            echo "Invalid choice!"
            ;;
    esac
done
