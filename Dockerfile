FROM ubuntu:16.04
MAINTAINER james@gauntlt.org

# Install Ruby.
RUN \
  apt-get update && \
  apt-get install -y build-essential \
    ca-certificates \
    curl \
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

# Install nikto
RUN apt-get update \
        && apt-get install -y libtimedate-perl libnet-ssleay-perl \
        && rm -rf /var/lib/apt/lists/*

ADD https://cirt.net/nikto/nikto-2.1.5.tar.gz /root/

WORKDIR /opt

RUN tar xzf /root/nikto-2.1.5.tar.gz \
        && rm /root/nikto-2.1.5.tar.gz \
        && echo "EXECDIR=/opt/nikto-2.1.5" >> nikto-2.1.5/nikto.conf \
        && ln -s /opt/nikto-2.1.5/nikto.conf /etc/nikto.conf \
        && chmod +x nikto-2.1.5/nikto.pl \
        && ln -s /opt/nikto-2.1.5/nikto.pl /usr/local/bin/nikto \
        && nikto -update

ENTRYPOINT [ "/usr/local/bin/gauntlt" ]
