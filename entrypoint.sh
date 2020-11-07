#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

INITIAL_VERSION="/tmp/ts-rs.tar.gz"



# download and install if needed
# assume: pwd = $VOLUME/..
if [ ! -f "$INITIAL_VERSION" ]; then
    curl -o "$INITIAL_VERSION" -L "https://codeload.github.com/Newcomer1989/TSN-Ranksystem/tar.gz/${RANKSYSTEM_VERSION}"
    tar -xf "$INITIAL_VERSION"
    mv -fv "$VOLUME/other/dbconfig.php" "/tmp/dbconfig.php" || true
    mv -fv TSN*/* "$VOLUME/"
    rm -rf TSN*
    mv -fv "/tmp/dbconfig.php" "$VOLUME/other/dbconfig.php" || true
fi



# fix permissions
chown -R 'www-data:www-data' "$VOLUME"



# default entrypoint
exec docker-php-entrypoint apache2-foreground
