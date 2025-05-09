#!/bin/bash
set -xe

PREFIX_DIR=${PREFIX_DIR:-/opt/xmlsec/prefix}

OPENSSL_URL="https://github.com/openssl/openssl/releases/download"
source /root/openssl-version.sh

curl -#LO "${OPENSSL_URL}/${OPENSSL_VERSION}/${OPENSSL_VERSION}.tar.gz"
echo "${OPENSSL_SHA256}  ${OPENSSL_VERSION}.tar.gz" | sha256sum -c -
tar zxf ${OPENSSL_VERSION}.tar.gz
pushd ${OPENSSL_VERSION}
BUILD_FLAGS="--prefix=${PREFIX_DIR} no-shared -fPIC --libdir=lib"
./config $BUILD_FLAGS
make -j4
make -j4 install_sw
popd
rm -rf openssl*