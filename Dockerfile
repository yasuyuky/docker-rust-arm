FROM ubuntu:xenial
MAINTAINER yasuyuky <yasuyuki.ymd@gmail.com>

RUN apt-get -y update \
&&  apt-get -y install \
                       gcc-arm-linux-gnueabihf \
                       curl \
                       g++
RUN curl -sSf https://sh.rustup.rs > rustup.sh && chmod +x rustup.sh && ./rustup.sh -y && rm rustup.sh
ENV PATH $PATH:/root/.cargo/bin
RUN rustup default stable
RUN rustup target add arm-unknown-linux-gnueabihf
RUN mkdir source \
&&  mkdir .cargo \
&&  echo "[target.arm-unknown-linux-gnueabihf]\nlinker = \"arm-linux-gnueabihf-gcc\"" > .cargo/config
WORKDIR source
CMD ["bash"]
