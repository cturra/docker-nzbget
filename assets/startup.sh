#!/bin/bash

WGET=$(which wget)

# do we want the stable or testing track?
if [ ! -z "${NZBGET_TRACK}" ]; then
  if [ ${NZBGET_TRACK} == "stable" ]; then
    echo "[INFO] Choosing the NZBGet stable branch."
  elif [ "${NZBGET_TRACK}" == "testing" ]; then
    echo "[INFO] Choosing the NZBGet testing branch."
  fi

# if NZBGET_TRACK environment variable is not set, choose stable
else
  echo "[INFO] NZBGET_TRACK environment variable unset. Auto selecting stable."
  export NZBGET_TRACK=stable
fi

# get stable release version from nzbget.com
NZBGET_DOWNLOAD_URL=$( $WGET --quiet                                                     \
                             --output-document                                           \
                             - http://nzbget.net/info/nzbget-version-linux.json         |\
                       sed --quiet "s/^.*${NZBGET_TRACK}-download.*: \"\(.*\)\".*/\1/p"
                     )

# download NZBGet
echo "[INFO] Downloading NZBGet from $NZBGET_DOWNLOAD_URL"
$WGET --no-check-certificate            \
      --output-document /tmp/nzbget.run \
      --quiet                           \
      ${NZBGET_DOWNLOAD_URL}            \

# run the installer
if [ -f /tmp/nzbget.run ]; then
  sh /tmp/nzbget.run
fi

# check if config is present in /data directory. if not, lets
# use the default config shipped with nzbget.
if [ ! -f /data/nzbget.conf ]; then
  echo "[INFO] Copying config into /data/nzbget.conf"
  cp /nzbget/nzbget.conf /data/nzbget.conf
fi

# remove .lock file if it's present
if [ -f /data/nzbget.lock ]; then
  rm --force /data/nzbget.lock
fi

# start nzbget
/nzbget/nzbget --configfile /data/nzbget.conf \
               --option OutputMode=log        \
               --server
