# DO NOT EDIT, This Dockerfile is generated from ./tools/10_generate_Dockerfile.sh
FROM bjodah/bjodahimg16base:v1.1
MAINTAINER Björn Dahlgren <bjodah@DELETEMEgmail.com>
RUN \
    apt-get update && apt-get --quiet --assume-yes --no-install-recommends install libssl-dev libboost-dbg && \
    apt-get clean && \
    export PATH=/root/.local/bin:$PATH && mkdir -p /root/.local && cd /tmp && \
    wget --quiet https://www.python.org/ftp/python/3.4.5/Python-3.4.5.tgz -O py34.tgz && \
    tar xzf py34.tgz && cd Python* && ./configure --with-pydebug --prefix /root/.local && make -s && \
    make install && mv /root/.local/bin/python3 /root/.local/bin/python3.4-dbg && \
    wget --quiet https://bootstrap.pypa.io/get-pip.py && python3.4-dbg get-pip.py --user && \
    DISTUTILS_DEBUG=1 python3.4-dbg -m pip install --no-binary :all: --global-option build --global-option --debug --user numpy cython scipy matplotlib && \
    mkdir -p /root/.config/matplotlib/ && \
    echo "backend: Agg" > /root/.config/matplotlib/matplotlibrc && \
    sed -i 's/TkAgg/Agg/g' /etc/matplotlibrc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
