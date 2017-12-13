#!/bin/bash

if [ "$#" -lt 1 ] || ! [ -r "$1" ]; then
	echo "Invalid parameters" >&2
  exit 1
	else
		find $1 -maxdepth 1 -type f -name "*$2" | wc -l
		exit 0
fi
