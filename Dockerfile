FROM rust:1.78.0-buster
LABEL maintainer="yasuyuky <yasuyuki.ymd@gmail.com>"

RUN apt-get -y update && apt-get -y install gcc-arm-linux-gnueabihf
RUN rustup target add arm-unknown-linux-gnueabihf
RUN mkdir -p /source /.cargo /usr/local/src && \
    echo "[target.arm-unknown-linux-gnueabihf]\nlinker = \"arm-linux-gnueabihf-gcc\"" > /.cargo/config
WORKDIR /usr/local/src
ENV OPENSSL_VER 1.1.1i
ENV CC arm-linux-gnueabihf-gcc
ENV PREFIX /usr/arm-linux-gnueabihf
ENV PATH /usr/local/bin:$PATH
ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig
RUN curl -sL http://www.openssl.org/source/openssl-$OPENSSL_VER.tar.gz | tar xz && \
    cd openssl-$OPENSSL_VER && \
    ./Configure no-shared --prefix=$PREFIX --openssldir=$PREFIX/ssl no-zlib linux-armv4 -fPIC && \
    make -j$(nproc) && make install && cd .. && rm -rf openssl-$OPENSSL_VER
ENV SSL_CERT_FILE /etc/ssl/certs/ca-certificates.crt
ENV SSL_CERT_DIR /etc/ssl/certs
ENV OPENSSL_LIB_DIR $PREFIX/lib
ENV OPENSSL_INCLUDE_DIR $PREFIX/include
ENV OPENSSL_DIR $PREFIX
ENV OPENSSL_STATIC 1
ENV PKG_CONFIG_ALLOW_CROSS 1
WORKDIR /source
CMD ["bash"]
