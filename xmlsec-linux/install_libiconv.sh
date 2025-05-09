#!/bin/bash
set -xe

PREFIX_DIR=${PREFIX_DIR:-/opt/xmlsec/prefix}

LIBICONV_URL="https://ftp.gnu.org/pub/gnu/libiconv"
source /root/libiconv-version.sh

curl -#LO "${LIBICONV_URL}/${LIBICONV_VERSION}.tar.gz"
echo "${LIBICONV_SHA256}  ${LIBICONV_VERSION}.tar.gz" | sha256sum -c -
tar zxf ${LIBICONV_VERSION}.tar.gz
pushd ${LIBICONV_VERSION}
BUILD_FLAGS="--prefix=${PREFIX_DIR} --disable-dependency-tracking --disable-shared"
./configure $BUILD_FLAGS
make -j4
make -j4 install
popd
rm -rf libiconv*