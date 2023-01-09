#!/bin/sh
set -x

# This script assumes this directory is stored somewhere the
# builder user will be able to access it, like /opt/radvd

doas apk --no-cache add alpine-sdk

doas adduser builder -D
doas addgroup builder abuild

doas apk update

doas mkdir -p /var/cache/distfiles

doas chown -R builder:abuild /var/cache/distfiles
doas chown -R builder:abuild .

doas -u builder abuild-keygen -a -n

doas -u builder abuild checksum

doas -u builder abuild -r

