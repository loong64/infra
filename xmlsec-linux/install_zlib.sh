#!/bin/bash
set -xe

PREFIX_DIR=${PREFIX_DIR:-/opt/xmlsec/prefix}

ZLIB_URL="https://zlib.net"
source /root/zlib-version.sh

curl -#LO "${ZLIB_URL}/${ZLIB_VERSION}.tar.gz"
echo "${ZLIB_SHA256}  ${ZLIB_VERSION}.tar.gz" | sha256sum -c -
tar zxf ${ZLIB_VERSION}.tar.gz
pushd ${ZLIB_VERSION}
BUILD_FLAGS="--prefix=${PREFIX_DIR}"
./configure $BUILD_FLAGS
make -j4
make -j4 install
popd
rm -rf zlib*