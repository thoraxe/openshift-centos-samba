#!/bin/bash
set -x

# https://unix.stackexchange.com/questions/146995/inherit-environment-variables-in-systemd-docker-container
# Import our environment variables from systemd
for e in $(tr "\000" "\n" < /proc/1/environ); do
  eval "export $e"
done

# user json comes in as base64 encoded
DECODEDJSON=$(echo $USERJSON | base64 -d)
groupadd $USERGROUP
for user in $(echo $DECODEDJSON | jq -r '.[].user')
do
  password=$(echo $DECODEDJSON | jq -r '.[] | select(.user=="'$user'") | .password')
  useradd -G smbusers -M -s /sbin/nologin $user
  printf "$password\n$password\n" | smbpasswd -a -s $user
done