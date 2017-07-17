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
RUN gem install arachni -v 1.5.1 --no-rdoc --no-ri

ENTRYPOINT [ "/usr/local/bin/gauntlt" ]
