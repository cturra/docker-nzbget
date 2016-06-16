#!/bin/bash

# check if config is present in /data directory. if not, lets
# use the default config shipped with nzbget.
if [ ! -f /data/nzbget.conf ]; then
  cp /usr/local/share/nzbget/nzbget.conf /data/nzbget.conf
fi

# remove .lock file if it's present
if [ -f /data/nzbget.lock ]; then
  rm -f /data/nzbget.lock
fi

# start nzbget
/usr/local/bin/nzbget --configfile /data/nzbget.conf \
                      --option OutputMode=log        \
                      --server
