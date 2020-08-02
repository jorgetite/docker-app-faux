#!/bin/sh

set -e

/bin/sed -i "s|{{base}}|$WEBFAUX_BASE_PATH|" /usr/share/nginx/html/index.html
echo "Base path was set to:" $WEBFAUX_BASE_PATH

exec /docker-entrypoint.sh "$@"