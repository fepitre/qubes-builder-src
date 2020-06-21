#!/bin/bash

set -e
[[ "$DEBUG" == 1 ]] && set -x

[ -z "$HOST" ] && HOST=distfiles.qubes-os.org
[ -z "$HOST_BASEDIR" ] && HOST_BASEDIR=/pub/qubes/repo/sources
[ -z "$RELEASE" ] && RELEASE=current-release

if [ "$AUTOMATIC_UPLOAD" = 1 ]; then
    echo "Syncing sources for $RELEASE..."
    rsync $DRY --partial --progress --hard-links --exclude repodata -air "${BUILDER_SRC_DIR}/r$RELEASE/sources" "$HOST:$HOST_BASEDIR/$RELEASE/"
fi