#!/bin/bash
set -xe

PREFIX_DIR=${PREFIX_DIR:-/opt/xmlsec/prefix}

LIBXML2_URL="https://download.gnome.org/sources/libxml2"
source /root/libxml2-version.sh

VERSION_PREFIX=$(echo "${LIBXML2_VERSION}" | cut -d'-' -f2 | cut -d'.' -f1,2)

curl -#LO "${LIBXML2_URL}/${VERSION_PREFIX}/${LIBXML2_VERSION}.tar.xz"
echo "${LIBXML2_SHA256}  ${LIBXML2_VERSION}.tar.xz" | sha256sum -c -
tar xf ${LIBXML2_VERSION}.tar.xz
pushd ${LIBXML2_VERSION}
BUILD_FLAGS="--prefix=${PREFIX_DIR} --disable-dependency-tracking --disable-shared --without-lzma --without-python --with-iconv=${PREFIX_DIR} --with-zlib=${PREFIX_DIR}"
./configure $BUILD_FLAGS
make -j4
make -j4 install
popd
rm -rf libxml2*