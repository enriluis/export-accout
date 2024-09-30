#!/bin/bash

# output file
OUTPUT_FILE="user_info.csv"

# Empty file if exist
> "$OUTPUT_FILE"

# Set Quota (ej, 2048)
QUOTA=2048

# Iterate over user account email stored in zimbra ldap
for i in $(zmprov -l gaa | egrep -v 'galsync|spam|ham|virus|stimpson'); do
    # get email address
    EMAIL="$i"

    # get displayName)
    DISPLAY_NAME=$(zmprov -l ga "$i" displayName | grep displayName | sed 's/displayName: //')

    # verify if display name are empty
    if [ -z "$DISPLAY_NAME" ]; then
        DISPLAY_NAME="N/A"
    fi

    # get password hash
    USER_PASSWORD=$(zmprov -l ga "$i" userPassword | grep userPassword | sed 's/userPassword: //')

    # Write output to file
    echo "$EMAIL,$DISPLAY_NAME,$USER_PASSWORD,$QUOTA" >> "$OUTPUT_FILE"
done

echo "Output write to  $OUTPUT_FILE"