#!/bin/bash
set -x

groupadd -g $GROUPID $GROUPNAME
for user in $(echo $USERJSON | jq -r '.[].user')
do
  password=$(echo $USERJSON | jq -r '.[] | select(.user=="'$user'") | .password')
  uid=$(echo $USERJSON | jq -r '.[] | select(.user=="'$user'") | .id')
  useradd -G $GROUPNAME -u $uid -M -s /sbin/nologin $user
  printf "$password\n$password\n" | smbpasswd -a -s $user
done