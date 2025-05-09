#!/bin/bash
set -xe

PREFIX_DIR=${PREFIX_DIR:-/opt/xmlsec/prefix}

XMLSEC1_URL="https://github.com/lsh123/xmlsec/releases/download"
source /root/xmlsec1-version.sh

VERSION_PREFIX=$(echo "${XMLSEC1_VERSION}" | cut -d'-' -f2)

export LDFLAGS="${LDFLAGS} -lpthread"

curl -#LO "${XMLSEC1_URL}/${VERSION_PREFIX}/${XMLSEC1_VERSION}.tar.gz"
echo "${XMLSEC1_SHA256}  ${XMLSEC1_VERSION}.tar.gz" | sha256sum -c -
tar xf ${XMLSEC1_VERSION}.tar.gz
pushd ${XMLSEC1_VERSION}
BUILD_FLAGS="--prefix=${PREFIX_DIR} --disable-shared --disable-gost --enable-md5 --disable-crypto-dl --enable-static=yes --enable-shared=no --enable-static-linking=yes --with-default-crypto=openssl --with-openssl=${PREFIX_DIR} --with-libxml=${PREFIX_DIR} --with-libxslt=${PREFIX_DIR}"
./configure $BUILD_FLAGS
make -j4 -I${PREFIX_DIR}/include -I${PREFIX_DIR}/include/libxml
make -j4 install
popd
rm -rf xmlsec1*
