#!/bin/bash
set -xe

PREFIX_DIR=${PREFIX_DIR:-/opt/xmlsec/prefix}

LIBXSLT_URL="https://download.gnome.org/sources/libxslt"
source /root/libxslt-version.sh

VERSION_PREFIX=$(echo "${LIBXSLT_VERSION}" | cut -d'-' -f2 | cut -d'.' -f1,2)

curl -#LO "${LIBXSLT_URL}/${VERSION_PREFIX}/${LIBXSLT_VERSION}.tar.xz"
echo "${LIBXSLT_SHA256}  ${LIBXSLT_VERSION}.tar.xz" | sha256sum -c -
tar xf ${LIBXSLT_VERSION}.tar.xz
pushd ${LIBXSLT_VERSION}
BUILD_FLAGS="--prefix=${PREFIX_DIR} --disable-dependency-tracking --disable-shared --without-python --without-crypto --with-libxml-prefix=${PREFIX_DIR}"
./configure $BUILD_FLAGS
make -j4
make -j4 install
popd
rm -rf libxslt*