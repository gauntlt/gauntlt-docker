FROM ubuntu:14.04
MAINTAINER james@gauntlt.org

# Install Ruby
RUN echo "deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu trusty main" > /etc/apt/sources.list.d/ruby.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C3173AA6
RUN \
  apt-get update && \
  apt-get install -y build-essential \
    ca-certificates \
    curl \
    wget \
    zlib1g-dev \
    libxml2-dev \
    libxslt1-dev \
    ruby2.0 \
    ruby2.0-dev && \
  rm -rf /var/lib/apt/lists/*

# Install Gauntlt
RUN gem install gauntlt --no-rdoc --no-ri

# Install Attack tools
RUN gem install arachni -v 1.0.6 --no-rdoc --no-ri

ENTRYPOINT [ "/usr/local/bin/gauntlt" ]
