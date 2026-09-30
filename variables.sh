#!/usr/bin/env bash

echo "Starting the script..."
echo "*----------------------------*"
NAME="Rodrigo Correa"
echo "My name is $NAME"
echo "*----------------------------*"
NUMBER_1=42
NUMBER_2=51
TOTAL=$((NUMBER_1 + NUMBER_2))
echo "The total of $NUMBER_1 and $NUMBER_2 is $TOTAL"
echo "*----------------------------*"
CAT_OUTPUT=$(cat /etc/passwd | grep rodrigo)

echo "The output of the cat command is: $CAT_OUTPUT"
echo "*-----------------------------------------------------------------------------*"
echo " "
echo "Parameter 1: $1"
echo "Parameter 2: $2"

echo "All parameters: $*"

echo "How many parameters were passed: $#"

echo "The last parameter passed was: $?"

echo "PID of the script: $$"

echo $0