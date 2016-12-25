#!/bin/sh

set -e

# if /config doesnt exist, exit
test -d /config || exit 1
# same goes for data
test -d /data || exit 2

mkdir -p /config/cache

touch /config/config.ini
touch /config/sickbeard.db
touch /config/sickbeard.db.v43

/usr/bin/python /sickrage/SickBeard.py --datadir=/config/ --config=/config/config.ini
