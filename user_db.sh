#!/usr/bin/env bash
# ------------------------------- VARIABLES ----------------------------------------- #
DATABASE_FILE="database.txt"
SEP=:
TEMP=temp.$$
GREEN="\033[32;1m"
RED="\033[31;1m"
# ------------------------------------------------------------------------ #

# ------------------------------- TESTS ----------------------------------------- #
[ ! -e "$DATABASE_FILE" ] && echo "ERROR. File does not exist." && exit 1
[ ! -r "$DATABASE_FILE" ] && echo "ERROR. File does not have read permission." && exit 1
[ ! -w "$DATABASE_FILE" ] && echo "ERROR. File does not have write permission." && exit 1
# ------------------------------------------------------------------------ #

# ------------------------------- FUNCTIONS ----------------------------------------- #
ShowUserOnScreen () {
  local id="$(echo $1 | cut -d $SEP -f 1)"
  local name="$(echo $1 | cut -d $SEP -f 2)"
  local email="$(echo $1 | cut -d $SEP -f 3)"

  echo -e "${GREEN}ID: ${RED}$id"
  echo -e "${GREEN}Name: ${RED}$name"
  echo -e "${GREEN}E-mail: ${RED}$email"
}

ListUsers () {
  while read -r line
  do
    [ "$(echo $line | cut -c1)" = "#" ] && continue
    [ ! "$line" ] && continue

    ShowUserOnScreen "$line"
  done < "$DATABASE_FILE"
}

ValidateUserExists () {
  grep -i -q "$1$SEP" "$DATABASE_FILE"
}

InsertUser () {
  local name="$(echo $1 | cut -d $SEP -f 2)"

  if ValidateUserExists "$name"
  then
    echo "ERROR. User already exists!"
  else
    echo "$*" >> "$DATABASE_FILE"
    echo "User successfully registered!"
  fi
  SortList
}

DeleteUser () {
  ValidateUserExists "$1" || return

  grep -i -v "$1$SEP" "$DATABASE_FILE" > "$TEMP"
  mv "$TEMP" "$DATABASE_FILE"

  echo "User successfully removed!"
  SortList
}

SortList () {
  sort "$DATABASE_FILE" > "$TEMP"
  mv "$TEMP" "$DATABASE_FILE"
}
# ------------------------------------------------------------------------ #

# ------------------------------- EXECUTION ----------------------------------------- #

# ----------------------------------------------------------------- #