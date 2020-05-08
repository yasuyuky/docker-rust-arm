FROM rust:1.43.1-stretch
LABEL maintainer="yasuyuky <yasuyuki.ymd@gmail.com>"

RUN apt-get -y update && apt-get -y install gcc-arm-linux-gnueabihf
RUN rustup target add arm-unknown-linux-gnueabihf
RUN mkdir -p /source /.cargo /usr/local/src \
&&  echo "[target.arm-unknown-linux-gnueabihf]\nlinker = \"arm-linux-gnueabihf-gcc\"" > /.cargo/config
WORKDIR /usr/local/src
ENV SSL_VER 1.0.2o
ENV CC arm-linux-gnueabihf-gcc
ENV PREFIX /usr/arm-linux-gnueabihf
ENV PATH /usr/local/bin:$PATH
ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig
RUN curl -sL http://www.openssl.org/source/openssl-$SSL_VER.tar.gz | tar xz \
&&  cd openssl-$SSL_VER \
&&  ./Configure no-shared os/compiler:arm-none-linux-gnueabihf- --prefix=$PREFIX --openssldir=$PREFIX/ssl no-zlib -fPIC \
&&  make -j$(nproc) && make install && cd .. && rm -rf openssl-$SSL_VER
ENV SSL_CERT_FILE /etc/ssl/certs/ca-certificates.crt
ENV SSL_CERT_DIR /etc/ssl/certs
ENV OPENSSL_LIB_DIR $PREFIX/lib
ENV OPENSSL_INCLUDE_DIR $PREFIX/include
ENV OPENSSL_DIR $PREFIX
ENV OPENSSL_STATIC 1
ENV PKG_CONFIG_ALLOW_CROSS 1
WORKDIR /source
CMD ["bash"]
