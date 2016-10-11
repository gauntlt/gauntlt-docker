FROM ubuntu:16.10
MAINTAINER james@gauntlt.org

ARG ARACHNI_RELEASE
ARG ARACHNI_VERSION

ENV PATH $PATH:/opt/$ARACHNI_RELEASE/bin
ENV GOPATH /opt/go
ENV SSLYZE_PATH /usr/local/bin/sslyze
ENV PATH $PATH:$GOPATH/bin:$GOROOT/bin:/opt/$ARACHNI_RELEASE/bin


## Add unprivileged user to run gauntlt
RUN useradd -c "Gauntlt User" -m -s /sbin/nologin gauntlt

# Install Ruby, Python and other dependencies
RUN apt update && apt install apt-utils -y && apt upgrade -y && \
  apt install -y build-essential \
  curl \
  wget \
  nmap \
  git \
  golang \
  python-dev \
  python-pip \
  python-setuptools \
  zlib1g-dev \
  libxml2-dev \
  libxslt1-dev \
  ruby2.3 \
  ruby2.3-dev && \
  rm -rf /var/lib/apt/lists/*

# Install Gauntlt
RUN gem install gauntlt --no-rdoc --no-ri

# Install Arachni using provided package, not the gem
# https://github.com/Arachni/arachni/issues/682#issuecomment-199371059
RUN cd /opt && wget https://github.com/Arachni/arachni/releases/download/v$ARACHNI_VERSION/$ARACHNI_RELEASE-linux-x86_64.tar.gz && \
  tar -xzf $ARACHNI_RELEASE-linux-x86_64.tar.gz

# Install sslyze and sqlmap
RUN pip install sslyze && ln -s $( which sslyze_cli.py ) /usr/local/bin/sslyze && \
  pip install sqlmap

# Install nosqlmap
RUN cd /opt && git clone https://github.com/tcstool/NoSQLMap.git && \
  cd NoSQLMap && \
  python setup.py install && \
  ln -s $( which nosqlmap.py ) /usr/local/bin/nosqlmap

# Install Heartbleed
RUN mkdir /opt/go && go get -u -v github.com/FiloSottile/Heartbleed && \
  ln -s $( which Heartbleed ) /usr/local/bin/Heartbleed

# Install Garmr
RUN cd /opt && git clone https://github.com/mozilla/Garmr.git && \
  cd Garmr && \
  python setup.py install

ENTRYPOINT [ "/usr/local/bin/gauntlt" ]
USER gauntlt
WORKDIR /working
CMD ["--help"]
