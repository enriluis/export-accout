Zimbra LDAP User Export Script

This script exports user accounts stored in the Zimbra LDAP database. The output file will have the following format:

henrik@domain.com,Display Name,{SSHA512}cHG6xXTUNGwRtfFh3U+1OyOcndfwwclvJ6/RMykjtMiLSt1b4sQCtM/f,2048

You can later import the generated output file into your Mailcow installation using the addMailboxes-1.0.1-linux tool.
ex.
./addMailboxes-1.0.1-linux -i usuarios_info.csv -s http://mailcow-ip -a OMJUBGT-QWEASD-QAZWSX-EDCRFV-TGBYHN

Requirements

    Zimbra server with access to the LDAP database.
    Bash shell environment.

Usage

    Save the script as export_zimbra_users.sh

    Make the script executable:
    bash

chmod +x export_zimbra_users.sh

Run the script:

    ./export_zimbra_users.sh

    The user account information will be saved in a file named usuarios_info.csv

Notes

    Ensure that your Zimbra server is running and that you have the necessary 
    permissions to access the LDAP database. The output file contains the email 
    address, display name, password hash, and a constant quota value (e.g., 2048).
    Remember run the scipt as zimbra user.

# Dovecot Mailcow IMAP Sync Script

## Overview

This repository contains a Bash script designed to synchronize email accounts using `imapsync` within a Dovecot Mailcow container. The script reads email addresses from a specified input file and performs synchronization for each account.

## Features

- Synchronizes email accounts from an input file.
- Supports configuration for master user credentials.
- Logs progress and handles errors during synchronization.

## Prerequisites

- Docker with Mailcow installed.
- Access to the Dovecot Mailcow container.
- `imapsync` installed and available in the container.
- An input file named `user_list.txt` containing email addresses to synchronize.

## Input File Format

- The input file should be named `user_list.txt`.
- Each line should contain one email address.

## Usage Instructions

1. **Access the Dovecot Mailcow Container**:

   Open a terminal and run:

   ```bash
   docker exec -it <container_name> /bin/bash