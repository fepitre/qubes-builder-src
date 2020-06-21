#!/bin/bash

set -e
[[ "$DEBUG" == 1 ]] && set -x

# shellcheck disable=SC2164
cd "$(dirname "$0")"

if [ -z "$UPDATE_REPO" ]; then
    echo "You need to specify destination repo in UPDATE_REPO variable"
    exit 1
fi

# Due to dummy dist "src" we remove the suffix
UPDATE_REPO=${UPDATE_REPO//dom0\/src}
COMPONENT_DIR="$BUILDER_DIR/$ORIG_SRC/pkgs/src/"

[ -z "$HOST" ] && HOST=distfiles.qubes-os.org
[ -z "$HOST_BASEDIR" ] && HOST_BASEDIR=/pub/qubes/repo/src
[ -z "$RELEASE" ] && RELEASE=current-release

if [ -e "$COMPONENT_DIR/${GIT_TARBALL_NAME}" ] && [ -e "$COMPONENT_DIR/${GIT_TARBALL_NAME}.asc" ]; then
    cd "$COMPONENT_DIR"
    mkdir -p "$UPDATE_REPO"
    ln -f "${GIT_TARBALL_NAME}" "$UPDATE_REPO"
    ln -f "${GIT_TARBALL_NAME}.asc" "$UPDATE_REPO"
else
    echo "Cannot find ${GIT_TARBALL_NAME} and it's signature file"
    exit 1
fi