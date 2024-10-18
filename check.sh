#!/usr/bin/bash

LOG="status.log"
TIME=$(date +"%Y-%m-%d %T")

check_website_status(){
	attempts=3
        while [ $attempts -gt 0 ]; do
                if curl --output /dev/null --silent $2; then
                        echo "$TIME: $1 is Operational" >> "$LOG"
                        echo "$1 ----- Operational"
                        break
                else
                        attempts=$((attempts-1))
                        echo "Retrying to connect to $1... [$attempts tries left]"
                        sleep 5
                fi
        done

        if [ $attempts -eq 0 ]; then
                echo "$TIME: $1 is offline" >> "$LOG"
                echo "$1 ----- Offline"
        fi
}


while IFS=" " read -r NAME SITE; do
	check_website_status $NAME $SITE &

done < sites.txt
wait
