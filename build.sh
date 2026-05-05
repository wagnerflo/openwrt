#!/bin/sh
set -e

NAME=$1
MAKE_JOBS=-j$(nproc)
STAMP=$(date +%s)

if [ -z "${NAME}" ]; then
    echo "usage: $0 NAME"
    exit 1
fi

cp build.config.${NAME} .config
make ${MAKE_JOBS} defconfig download clean 2>&1 | \
    tee build.log.${NAME}.${STAMP}
make ${MAKE_JOBS} world V=s EXTRA_IMAGE_NAME=${NAME} 2>&1 | \
    tee -a build.log.${NAME}.${STAMP}
