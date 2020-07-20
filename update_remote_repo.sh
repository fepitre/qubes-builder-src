#!/bin/bash

set -e
[[ "$DEBUG" == 1 ]] && set -x

RELEASE="$1"

if [ -z "$UPDATE_REPO" ]; then
    echo "You need to specify destination repo in UPDATE_REPO variable"
    exit 1
fi

[ -z "$HOST" ] && HOST=distfiles.qubes-os.org
[ -z "$HOST_BASEDIR" ] && HOST_BASEDIR=/pub/qubes/repo/src

UPDATE_REPO=${UPDATE_REPO//current*\/dom0\/src}

if [ "$AUTOMATIC_UPLOAD" = 1 ]; then
    echo "Syncing sources..."
    rsync $DRY --partial --progress --hard-links --exclude repodata -air "${UPDATE_REPO}/common" "$HOST:$HOST_BASEDIR/"
    rsync $DRY --partial --progress --hard-links --exclude repodata -air "${UPDATE_REPO}/$RELEASE" "$HOST:$HOST_BASEDIR/"
fi