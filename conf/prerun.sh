#!/bin/sh

set -e

# check if config is present in /data directory. if not, lets
# use the default config shipped with nzbget.
if [ ! -f /data/nzbget.conf ]; then
  cp /usr/local/share/nzbget/nzbget.conf /data/nzbget.conf
fi
