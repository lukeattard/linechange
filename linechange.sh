#!/bin/bash

function display_help {
  echo "Usage: linechange <option> <pattern> <replace> <file>"
  echo "where option is one of:"
  echo " -S    Replace string if it appears at the start of the line"
  echo " -E    Replace string if it appears at the end of the string"
  echo " -F    Replace only the first time the string appears"
  echo " -A    Replace ALL instances of the string"
  echo " "
  echo " "
}

if [ $# != 4 ]; then
	display_help
	exit
fi

plength=${#2}

if [ $1 == '-E' ]; then

	while read -r line; do
		if [ "${line: -$plength}" == "$2" ]
		then
			echo "${line%$2}$3"
		else
			echo "$line"
		fi
	done < "$4"

elif [ $1 == '-S' ]; then

    while read -r line; do
        if [ "${line:0:$plength}" == "$2" ]
        then
            echo "${3}${line#$2}"
        else
            echo "$line"
        fi
    done < "$4"

elif [ $1 == "-F" ]; then

	while read -r line; do
        echo "${line/$2/$3}"
    done < "$4"

elif [ $1 == "-A" ]; then

    while read -r line; do
        echo "${line//$2/$3}"
    done < "$4"

else
	display_help
fi

