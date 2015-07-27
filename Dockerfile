FROM ubuntu:latest
MAINTAINER yasuyuky <yasuyuki.ymd@gmail.com>

ENV RUST_VERSION=1.1.0

RUN apt-get -y update \
&&  apt-get -y install git \
                       gcc-arm-linux-gnueabihf \
                       make \
                       curl \
                       python2.7 \
                       llvm-3.4 \
                       clang \
                       g++ \
                       libssl-dev
RUN mkdir /src \
&&  cd /src \
&&  curl -sSf https://static.rust-lang.org/dist/rustc-${RUST_VERSION}-src.tar.gz | tar xzf - \
&&  cd rustc-${RUST_VERSION} \
&&  ./configure --target=x86_64-unknown-linux-gnu,arm-unknown-linux-gnueabihf \
&&  make && make install \
&&  cd /src \
&&  rm -rf rustc-${RUST_VERSION}
RUN curl -sSf https://static.rust-lang.org/cargo-dist/cargo-nightly-x86_64-unknown-linux-gnu.tar.gz | tar xzf - \
&&  cd cargo-nightly-x86_64-unknown-linux-gnu \
&&  ./install.sh \
&&  cd / \
&&  rm -rf src
RUN mkdir source \
&&  mkdir .cargo \
&&  echo "[target.arm-unknown-linux-gnueabihf]\nlinker = \"arm-linux-gnueabihf-gcc-4.8\"" > .cargo/config
WORKDIR source
CMD ["bash"]
