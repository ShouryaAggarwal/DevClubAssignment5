#!/bin/bash

if [ "$#" -ne 2 ] || ! [ -r "$1" ]; then
	echo "Invalid parameters" >&2
  exit 1
fi

size1=` grep ".*:.*:.*:.*:.*:.*:.*" $1 | wc -l ` 
size2=` cat $1 | wc -l `

if [ $size1 -eq $size2 ]
then
	let flag=0
	x=0
	while read line; 
	do
		x=$(( x+1 ))
		check=`sed -n "$x"p $1 | cut -d ':' -f 1`
		if [ "$check" == "$2" ]
			then
			found=`sed -n "$x"p $1 | cut -d ':' -f 5`
			let flag++
			echo $found
			break
		fi
	done <<< "$( cat "$1" )"
	
	if [ $flag -eq 0 ]
		then
		echo "Name not found"
	fi
	exit 0
else
echo "File format not supported" >&2
exit 1
fi



