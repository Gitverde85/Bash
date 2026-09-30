#!/usr/bin/env bash

VAR1="a"
VAR2="b"

if [[ "$VAR1" = "$VAR2" ]]; then
    echo "VAR1 is equal to VAR2"
else
    echo "VAR1 is not equal to VAR2"
fi

[ "$VAR1" = "$VAR2" ] ||  echo "VAR1 is not equal to VAR2" 
echo " "
echo "*-----------------------------------*"

PARAMETER="$1"
echo "Parameter 1: $PARAMETER"

if [[ "$PARAMETER" -ge "10" ]]; then
    echo "Parameter is greater than or equal to 10"
else
    echo "Parameter is less than 10"
fi

echo "PID: $$"
echo "Script name: $0"

echo "*-----------------------------------*"

if [ "$1" -gt 10 ] ; then echo "Parameter is greater than 10 | PID is $$"; else echo "Parameter is less than or equal to 10"; fi
if [ "$1" -lt 10 ]; then echo "Less than 10 | PID: $$"; else echo "10 or greater | PID: $$"; fi


