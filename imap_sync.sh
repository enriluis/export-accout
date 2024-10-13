#!/bin/bash

# run this script from inside you dovecot mailcow container

INPUT_FILE="user_list.txt"

# Chek if user exist
if [[ ! -f "$INPUT_FILE" ]]; then
    echo "El archivo $INPUT_FILE no existe."
    exit 1
fi

# get username and passwd
output=$(cat /etc/sogo/sieve.creds)
master_user=$(echo "$output" | awk -F':' '{print $1}')
master_pwd=$(echo "$output" | awk -F':' '{print $2}')

echo "Starting sync from $INPUT_FILE..."

#  read all lines of the input file
while IFS= read -r EMAIL; do
    if [[ -z "$EMAIL" ]]; then
        continue
    fi

    echo "Proscesing: $EMAIL"
    
    /usr/local/bin/imapsync \
        --tmpdir /tmp \
        --nofoldersizes \
        --addheader \
        --delete2duplicates \
        --subscribeall \
        --automap \
        --host1 ******* \
        --user1 "$EMAIL" \
        --authuser1 admin \
        --password1 "*******" \
        --port1 143 \
        --host2 localhost \
        --user2 "${EMAIL}*${master_user}" \
        --password2 "${master_pwd}" \
        --authmech2 LOGIN \
        --nossl2 \
        --notls2 \
        --no-modulesversion \
        --noreleasecheck \

done < "$INPUT_FILE"