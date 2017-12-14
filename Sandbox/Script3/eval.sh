#!/bin/bash

if [ "$#" -ne 1 ] || ! [ -r "$1" ]; then
	echo "Invalid parameters" >&2
  exit 1
fi

let result=0
x=0
	while read line
		do
		x=$(( x+1 ))
		operand=`sed -n "$x"p $1 | cut -d' ' -f 1`
		operator=`sed -n "$x"p $1 | cut -d' ' -f 2`
		case $operator in
			+)
				result=$(( result + operand ))
				;;
			-)
				result=$(( result - operand ))
				;;
			\*)
				result=$(( result * operand ))
				;;
			/)
				result=$(( result / operand ))
				;;
			*)
				echo Line $x not supported by script
				;;
		esac
	done <<< "$( cat "$1" )"
	
echo $result
exit 0
