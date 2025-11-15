FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    build-essential \
    ca-certificates \
    libstdc++6 \
    gcc \
    make \
    wget \
    tar \
    libssl-dev \
    file \
    curl \
    g++-aarch64-linux-gnu \
    binutils-aarch64-linux-gnu \
    gcc-aarch64-linux-gnu \
    gfortran \
    gdb-multiarch \
    pkg-config

WORKDIR /sdk

RUN wget -q https://github.com/trimui/toolchain_sdk_smartpro/releases/download/20231018/aarch64-linux-gnu-7.5.0-linaro.tgz && \
    tar -xzf aarch64-linux-gnu-7.5.0-linaro.tgz -C /sdk && \
    rm aarch64-linux-gnu-7.5.0-linaro.tgz

RUN mv /sdk/aarch64-linux-gnu-7.5.0-linaro/bin /sdk/aarch64-linux-gnu-7.5.0-linaro/bin.disabled

RUN wget -q https://github.com/trimui/toolchain_sdk_smartpro/releases/download/20231018/SDK_usr_tg5040_a133p.tgz && \
    tar -xzf SDK_usr_tg5040_a133p.tgz -C /sdk && \
    rm SDK_usr_tg5040_a133p.tgz

RUN wget -q https://github.com/trimui/toolchain_sdk_smartpro/releases/download/20231018/SDL2-2.26.1.GE8300.tgz && \
    tar -xzf SDL2-2.26.1.GE8300.tgz -C /sdk && \
    rm SDL2-2.26.1.GE8300.tgz

#ENV PATH="/sdk/aarch64-linux-gnu-7.5.0-linaro/bin:$PATH"

ENV SYSROOT="/sdk/usr"
ENV SDL_DIR="/sdk/SDL2-2.26.1"

ENV CXX=aarch64-linux-gnu-g++
ENV CXXFLAGS="-I$(SDL_DIR)/include -I$(SYSROOT)/include"
ENV LDFLAGS="-L$(SYSROOT)/lib -L$(SYSROOT)/lib/mali -Wl,-rpath-link=$(SYSROOT)/lib/mali"
ENV LIBS="-lSDL2 -lSDL2_ttf -lfreetype -lz -lbz2 -lGLESv2 -lEGL -lIMGegl -lsrv_um -lusc -lglslcompiler -lm"

WORKDIR /workspace

CMD ["/bin/bash"]
