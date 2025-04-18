FROM ghcr.io/loong64/alpine:latest
ARG VERSION
# One of x64 or arm64
ARG ARCH
# The sha256sum for the node source tarball
ARG SHA256SUM

RUN mkdir -p /build
WORKDIR /build

RUN apk add --no-cache ccache curl g++ gcc gnupg libgcc linux-headers make python3 libstdc++
RUN mkdir -p /out/bin

RUN curl -O https://nodejs.org/dist/$VERSION/node-$VERSION.tar.gz
RUN echo "$SHA256SUM  node-$VERSION.tar.gz" | sha256sum -c -
RUN tar -zxvf node-$VERSION.tar.gz

RUN --mount=type=cache,target=/root/.cache \
  export CC="ccache gcc" && \
  export CXX="ccache g++" && \
  cd node-$VERSION && \
  ./configure --dest-cpu=$ARCH --fully-static --openssl-no-asm && make -j$(nproc)

RUN cp /build/node-$VERSION/LICENSE /out/LICENSE && cp /build/node-$VERSION/out/Release/node /out/bin/node

FROM scratch
COPY --from=0 /out/ /out
