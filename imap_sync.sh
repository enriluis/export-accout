#!/bin/bash

# Inout flie exported by the other script
INPUT_FILE="user_info.csv"

# check if file exist
if [[ ! -f "$INPUT_FILE" ]]; then
    echo "The File  $INPUT_FILE do not exist."
    exit 1
fi

# Iterate ove each line int file
while IFS=',' read -r EMAIL DISPLAY_NAME PASSWORD QUOTA; do
    # run imapsync
    docker compose exec dovecot-mailcow /usr/local/bin/imapsync \
        --tmpdir /tmp \
        --nofoldersizes \
        --addheader \
        --delete2duplicates \
        --subscribeall \
        --automap \
        --host1 192.168.0.8 \
        --user1 "$EMAIL" \
        --authuser1 admin \
        --password1 "cmlk.c0.cu" \
        --port1 143 \
        --host2 localhost \
        --user2 "${EMAIL}*uo7yl4npslq0hm4f@mailcow.local" \
        --password2 "jq1yvz665gzzyav8zk9kgbmo" \
        --authmech2 LOGIN \
        --nossl2 \
        --notls2 \
        --no-modulesversion \
        --noreleasecheck

    # check if all is ok 
    if [[ $? -ne 0 ]]; then
        echo "Error sync: $EMAIL"
    else
        echo "Sync ok : $EMAIL"
    fi
done < "$INPUT_FILE"