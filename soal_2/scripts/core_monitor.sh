#!/bin/bash

LOG_FILE="./log/core.log"
DATE=$(date "+%Y-%m-%d %H:%M:%S")
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
CPU_MODEL=$(lscpu | grep "Model name" | awk -F ':' '{print $2}' | sed 's/^[ \t]*//')

echo "[$DATE] - Core Usage [$CPU_USAGE%] - Terminal Model [$CPU_MODEL]" >> "$LOG_FILE"
echo "CPU Usage: $CPU_USAGE% | Model: $CPU_MODEL"
