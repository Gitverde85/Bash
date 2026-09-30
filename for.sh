#!/usr/bin/env bash

echo "For 1"
for ((  i = 0; i < 10; i++)); do
    echo "Iteration $i"
done
echo "Loop completed."
echo " "
echo "For 2 seq"

for i in $(seq 10); do
    echo "Number: $i"
done

echo "All iterations done."
echo " "
echo "For 3 array"

Fruits=("Apple" "Banana" "Cherry" "Date")
for fruit in "${Fruits[@]}"; do
    echo "Fruit: $fruit"
done
echo "All fruits processed."

echo " "
echo "While loop example"
count=0
while [[ $count -lt ${#Fruits[@]} ]]; do
    echo $count
    count=$((count + 1))
done
echo "While loop completed."

echo " "

echo "counting to 10"

for i in $(seq 10); do
    if (( i % 2 == 0 )); then
        echo "$i is even"
    else
        echo "$i is odd"
    fi
done

echo " "

echo "counting to 10 using && and ||"
for i in $(seq 0 10)
do 
    [[ $((i % 2)) -eq 0 ]] && echo "$i is even" || echo "$i is odd"
done