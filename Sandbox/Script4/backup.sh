#!/bin/bash

if [ "$#" -ne 2 ] || ! [ -r "$1" ] || ! [ -r "$2" ]; then
	echo "Invalid parameters" >&2
  exit 1
fi

copy ()
{
	while read line
do	
	local last="${line: -1}"
	if [ $last != '/' ]
		then
			local var1=$1/$line
			local var2=$2/$line
			if [ "$var1" -nt "$var2" ]
				then
				cp -fup $var1 $2
				echo ` echo $var1 | cut -d '/' -f 1 --complement `
			fi
		else
			local var=` echo $line | cut -d '/' -f 1 `
			local new1="$1/$var"
			local new2="$2/$var"
			copy $new1 $new2
	fi
done <<< "$( ls -1p "$1" )"

}


echo "Files copied from /$1 to /$2 are :"
copy $1 $2

echo "Files copied from /$2 to /$1 are :"
copy $2 $1
