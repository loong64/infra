ARG NODE_ARCH_RELEASE
ARG PYCA_RELEASE
FROM quay.io/pypa/${PYCA_RELEASE}

WORKDIR /root
RUN \
  if stat /etc/redhat-release 1>&2 2>/dev/null; then \
    yum -y install perl perl-core perl-IPC-Cmd  && \
    yum -y clean all && \
    rm -rf /var/cache/yum; \
  fi

# This is done as two separate steps because readelf (binutils) is not available on
# aarch64.
RUN \
  if stat /etc/anolis-release 1>&2 2>/dev/null; then \
    yum -y install perl perl-core perl-IPC-Cmd && \
    yum -y clean all && \
    rm -rf /var/cache/yum; \
   fi

ARG PREFIX_DIR=/opt/xmlsec/prefix
ENV CFLAGS="${CFLAGS} -fPIC"

ADD *.sh /root/

RUN chmod +x *.sh && \
    ./install_openssl.sh && \
    ./install_zlib.sh && \
    ./install_libiconv.sh && \
    ./install_libxml2.sh && \
    ./install_libxslt.sh && \
    ./install_xmlsec1.sh

ENV PATH=${PREFIX_DIR}/bin:${PATH}
ENV LD_LIBRARY_PATH=${PREFIX_DIR}/lib:${LD_LIBRARY_PATH}
ENV PKG_CONFIG_PATH=${PREFIX_DIR}/lib/pkgconfig:${PKG_CONFIG_PATH}