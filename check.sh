#!/usr/bin/bash

LOG="status.log"

check_website_status(){
	attempts=3
        while [ $attempts -gt 0 ]; do
                if curl --output /dev/null --silent $2; then
                        status="Online"
                        echo -e "$1 ($2) -- \033[32m$status\033[0m -- $(date)" >> "$LOG"
                        echo "$1 ----- Operational"
                        break
                else
                        attempts=$((attempts-1))
                        echo "Retrying to connect to $1... [$attempts tries left]"
                        sleep 5
                fi
        done

        if [ $attempts -eq 0 ]; then
		status="Offline"
                echo -e "$1 ($2) -- \033[31m$status\033[0m -- $(date)" >> "$LOG"
                echo "$1 ----- Offline"
        fi
}


while IFS=" " read -r NAME SITE; do
	check_website_status $NAME $SITE &

done < sites.txt
wait
