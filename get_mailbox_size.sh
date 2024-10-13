#!/bin/bash
# # zmprov -l gaa > /tmp/user_list.txt
all_account=`zmprov -l gaa`;
for account in ${all_account}
do
    mb_size=`zmmailbox -z -m ${account} gms`;
    echo "${account} = ${mb_size}" >> mailbox_size.txt;
done