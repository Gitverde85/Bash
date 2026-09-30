#!/usr/bin/env bash

# userlist.sh - extracts a list of users from /etc/passwd and outputs it to a file
# Put in uppercase and sort the list alphabetically

USERS="$(cat /etc/passwd | cut -d : -f 1)"
MESSAGE="
    $(basename $0) | - [OPTIONS]

        -h - Help Menu
        -v - Version
        -s - Sort the list alphabetically
        -m - Make the list uppercase
"
VERSION="1.0.0"

# if [ "$1" = "-h" ]; then
#     echo "$MESSAGE" && exit 0
# fi
# if [ "$1" = "-v" ]; then
#     echo "$VERSION" && exit 0
# fi
# if [ "$1" = "-s" ]; then
#     echo "$USERS" | tr '[:lower:]' '[:upper:]' | sort && exit 0
# fi
# if [ "$1" = "-m" ]; then
#     echo "$USERS" | tr '[:lower:]' '[:upper:]' && exit 0
# fi
set -x
while  test -n "$1"; do
    case "$1" in
        -h)     echo "$MESSAGE" && exit 0                                               ;;
        -v)     echo "$VERSION" && exit 0                                                ;;
        -s)     echo "$USERS" | sort && exit 0                                            ;;
        -m)     echo "$USERS" | tr '[:lower:]' '[:upper:]' && exit 0               ;;
         *)      echo "Invalid option. Use -h for help." && exit 1                ;;
    esac
done
# case "$1" in
#     -h)     echo "$MESSAGE" && exit 0                                               ;;
#     -v)     echo "$VERSION" && exit 0                                                ;;
#     -s)     echo "$USERS" | sort && exit 0                                            ;;
#     -m)     echo "$USERS" | tr '[:lower:]' '[:upper:]' && exit 0               ;;
#      *)      echo "Invalid option. Use -h for help." && exit 1                ;;
# esac
set +x