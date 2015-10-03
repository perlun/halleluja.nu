#!/bin/sh

IP=85.134.56.45

if [ -z `ssh-keygen -F $IP` ]; then
  ssh-keyscan -H $IP >> ~/.ssh/known_hosts
fi

rsync -gloprtv --delete . www-data@$IP:www.halleluja.nu/
