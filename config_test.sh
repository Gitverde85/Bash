#!/usr/bin/env bash

CONFIG_FILE="config.cf"
COLOR=
UPPERCASE=
MESSAGE="Message test"

GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

[ ! -r "$CONFIG_FILE" ] && echo -e "${RED}Error: Config file not found or not readable${NC}" && exit 1

DefineParam ( ) {
    local parameter="$(echo $1 | cut -d = -f 1)"
    local value="$(echo $1 | cut -d = -f 2)"

    case "$parameter" in 
        COLOR) COLOR="$value" ;;
        UPPERCASE) UPPERCASE="$value" ;;
    esac
}

while read -r line
do
    [ "$(echo "$line" | cut -c1)" = "#" ] && continue
    [ ! "$line" ] && continue
    DefineParam "$line"
done < "$CONFIG_FILE"

[ "$UPPERCASE" = "1" ] && MESSAGE="$(echo -e $MESSAGE | tr '[:lower:]' '[:upper:]')"
[ "$COLOR" = "1" ] && MESSAGE="${GREEN}${MESSAGE}${NC}"

  echo -e "$MESSAGE"