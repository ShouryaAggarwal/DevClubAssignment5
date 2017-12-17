#!/bin/bash

if [ "$#" -ne 1 ] || ! [ -r "$1" ]; then
	echo "Invalid parameters" >&2
  exit 1
fi


l1=` grep ".* +" $1 | wc -l `
l2=` grep ".* -" $1 | wc -l `
l3=` grep ".* /" $1 | wc -l `
l4=` grep ".* \*" $1 | wc -l `
let size1=$l1+$l2+$l3+$l4
size2=` grep . $1 | wc -l `

if [ $size1 -ne $size2 ]
then
	echo "File format not supported" >&2
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
