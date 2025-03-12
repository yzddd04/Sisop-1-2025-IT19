#!/bin/bash

LOG_FILE="./log/fragment.log"
DATE=$(date "+%Y-%m-%d %H:%M:%S")
RAM_USAGE=$(free | grep Mem | awk '{printf "%.2f", $3/$2 * 100}')
TOTAL_RAM=$(free -m | grep Mem | awk '{print $2}')
AVAILABLE_RAM=$(free -m | grep Mem | awk '{print $7}')

echo "[$DATE] - Fragment Usage [$RAM_USAGE%] - Fragment Count [$AVAILABLE_RAM MB] - Details [Total: $TOTAL_RAM MB, Available: $AVAILABLE_RAM MB]" >> "$LOG_FILE"
echo "RAM Usage: $RAM_USAGE% | Total: $TOTAL_RAM MB | Available: $AVAILABLE_RAM MB"
