#!/usr/bin/bash

LOG="status.log"
TIME=$(date +"%Y-%m-%d %T")

while IFS=" " read -r NAME SITE; do
	attempts=3
	while [ $attempts -gt 0 ]; do	
		if curl --output /dev/null --silent $SITE; then
			echo "$TIME: $NAME is Operational" >> "$LOG"
			echo "$NAME ----- Operational"
			break
		else
			attempts=$((attempts-1))
			echo "Retrying to connect to $NAME... [$attempts tries left]"
			sleep 5
		fi
	done

	if [ $attempts -eq 0 ]; then
		echo "$TIME: $NAME is offline" >> "$LOG"
		echo "$NAME ----- Offline"
	fi
done < sites.txt
