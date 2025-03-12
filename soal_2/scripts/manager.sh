#!/bin/bash

CRON_JOB_CPU="* * * * * /bin/bash $(pwd)/scripts/core_monitor.sh"
CRON_JOB_RAM="* * * * * /bin/bash $(pwd)/scripts/frag_monitor.sh"

function add_cpu_monitor {
    (crontab -l 2>/dev/null; echo "$CRON_JOB_CPU") | crontab -
    echo "CPU Monitoring Added to Crontab."
}

function remove_cpu_monitor {
    crontab -l | grep -v "$CRON_JOB_CPU" | crontab -
    echo "CPU Monitoring Removed from Crontab."
}

function add_ram_monitor {
    (crontab -l 2>/dev/null; echo "$CRON_JOB_RAM") | crontab -
    echo "RAM Monitoring Added to Crontab."
}

function remove_ram_monitor {
    crontab -l | grep -v "$CRON_JOB_RAM" | crontab -
    echo "RAM Monitoring Removed from Crontab."
}

function view_jobs {
    crontab -l
}

while true; do
    echo "1. Add CPU Monitoring"
    echo "2. Remove CPU Monitoring"
    echo "3. Add RAM Monitoring"
    echo "4. Remove RAM Monitoring"
    echo "5. View Crontab Jobs"
    echo "6. Exit"
    read -p "Choose an option: " choice

    case $choice in
        1) add_cpu_monitor ;;
        2) remove_cpu_monitor ;;
        3) add_ram_monitor ;;
        4) remove_ram_monitor ;;
        5) view_jobs ;;
        6) exit 0 ;;
        *) echo "Invalid option!" ;;
    esac
done
