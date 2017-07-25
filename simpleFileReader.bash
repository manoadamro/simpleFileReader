#!/usr/bin/env bash

# simpleFileReader /path/to/file number_of_displayed_lines
# To Do:
#	- instead of using the current for loop,
#	it might be better to find a command for something like:
#		echo  'find line x and y-1 following lines'
#	where x is the current index and y is number of lines to display


# Get file path from cl args
FILE=$1

if [ -z "$FILE" ]; then
	echo "File path must be defined"
	exit
fi

# Get line display count from cl args
LINES=$2

if [ -z "$LINES" ]; then
	echo "Number of displayed lines must be defined"
	exit
fi

# set current index to 1 to start at beginning of file
CURRENT_INDEX=1

# get total number of lines in file
LINE_COUNT=$(cat $FILE | wc -l)

# show number of lines in file
# echo "lines: $LINE_COUNT"

# input loop
while true; do

	# clear the console screen
	clear

	# some empty lines to keep things pretty
	printf "\n"

	# display the current start line
	echo $CURRENT_INDEX

	# some empty lines to keep things pretty
	printf "\n"

	# display the current line and x-1 following lines
	for (( i = 0; i < $LINES; i++ )); do

		# get current line to display
		THIS_LINE=$(($CURRENT_INDEX+$i))

		# if the current line is greater than total line count
		if [ "$THIS_LINE" -ge "$LINE_COUNT" ]; then
			break
		fi

		# get that line!
		# i am positive there is a more efficient command for this
		echo "$(cat $FILE | head -n $THIS_LINE | tail -n 1)"
	done

	# some empty lines to keep things pretty
	printf "\n\n\n"

	# user instructions
	echo "w: up, s: down, x: quit"

	# read users input
	read INPUT

	# if the user entered x, quit
	if [ "$INPUT" == "x" ]; then
		exit

	# if the user entered w, scroll up x lines
	elif [ "$INPUT" == "w" ]; then
		CURRENT_INDEX=$(($CURRENT_INDEX - $LINES))

	# if the user entered w, scroll down x lines
	elif [ "$INPUT" == "s" ]; then
		CURRENT_INDEX=$(($CURRENT_INDEX + $LINES))
	fi

	# if the index is below 1, make it 1
	if [ "$CURRENT_INDEX" -le 0 ]; then
		CURRENT_INDEX=1

	# if the index is above line count, make it equal
	elif [ "$CURRENT_INDEX" -ge "$LINE_COUNT" ]; then
		CURRENT_INDEX=$(($LINE_COUNT))
	fi

# end of loop
done
