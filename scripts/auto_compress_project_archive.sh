#!/bin/bash

WATCHED_DIR="$HOME/Projects/archive"
DELAY=10

inotifywait -m -e create -e moved_to --format '%w%f' "$WATCHED_DIR" | while read NEWITEM
do
	i = ""
	while [[ -a "$NEWITEM$i*.gz" ]]
	do
		if [[ -z i ]]; then
			i = 2
		else
			i = i + 1
		fi
	done
	ARCHIVENAME = "$NEWITEM$i"
    if [[ "$NEWITEM" != *.gz ]]; then
	    if [ -d "$NEWITEM" ]; then
		# If it's a directory, compress its contents
		sleep $DELAY
		tar -czpf "${ARCHIVENAME}.tar.gz" -C "$NEWITEM" .
	    else
		# If it's a file, compress it
		gzip -c "$NEWITEM" > "${ARCHIVENAME}.gz"
	    fi
	    if [ $? -eq 0 ]; then
		# If archiving succesfull
		rm -rf "$NEWITEM"
	    fi
    fi
done

