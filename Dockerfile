FROM ubuntu:16.04
MAINTAINER james@gauntlt.org

# Install Ruby.
RUN \
  apt-get update && \
  apt-get install -y build-essential \
    ca-certificates \
    curl \
    git \
    libcurl3 \
    libcurl4-openssl-dev \
    wget \
    zlib1g-dev \
    libxml2-dev \
    libxslt1-dev \
    ruby \
    ruby-dev \
    ruby-bundler && \
    rm -rf /var/lib/apt/lists/*

# Install Gauntlt
RUN gem install gauntlt --no-rdoc --no-ri

# Install Attack tools

# Install arachni
RUN gem install arachni -v 1.5.1 --no-rdoc --no-ri

# Nikto
WORKDIR /opt

RUN apt-get update \
        && apt-get install -y libtimedate-perl libnet-ssleay-perl \
        && rm -rf /var/lib/apt/lists/*

RUN git clone --depth=1 https://github.com/sullo/nikto.git && \
    cd nikto/program && \
    echo "EXECDIR=/opt/nikto/program" >> nikto.conf && \
    ln -s /opt/nikto/program/nikto.conf /etc/nikto.conf && \
    chmod +x nikto.pl && \
    ln -s /opt/nikto/program/nikto.pl /usr/local/bin/nikto


ENTRYPOINT [ "/usr/local/bin/gauntlt" ]
