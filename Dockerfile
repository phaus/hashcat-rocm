FROM rocm/rocm-terminal:latest

LABEL LABEL maintainer="Philipp Haussleiter <philipp.haussleiter@innoq.com>"

USER root

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt install -y apt-utils wget ocl-icd-libopencl1 git build-essential

RUN mkdir /installs && \
    mkdir /installs/apps && \ 
    cd /installs/apps && \
    git clone https://github.com/hashcat/hashcat && \
    cd /installs/apps/hashcat && \
    git submodule update --init && \
    make && \
    chmod +x /installs/apps/hashcat/hashcat

RUN cd /installs/apps && \
    git clone https://github.com/hashcat/hashcat-utils && \
    cd /installs/apps/hashcat-utils/src && \
    make && \
    cp *.bin ../bin

RUN mkdir /installs/apps/wordlists && \
    cd /installs/apps/wordlists && \
    wget https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt

RUN apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

ENTRYPOINT ["/installs/apps/hashcat/hashcat"]
