FROM ubuntu:19.04
MAINTAINER james@gauntlt.org

ARG ARACHNI_VERSION=arachni-1.5.1-0.5.12
WORKDIR /opt

# Install Ruby, Gauntlt and everything needing build-essential
RUN apt update && \
    apt install -y build-essential \
      bzip2 \
      ca-certificates \
      curl \
      gcc \
      git \
      libcurl4 \
      libcurl4-openssl-dev \
      wget \
      zlib1g-dev \
      libfontconfig \
      libxml2-dev \
      libxslt1-dev \
      make \
      python-pip \
      xmlstarlet \
      python2.7 \
      python2.7-dev \
      ruby \
      ruby-dev \
      openjdk-8-jre \
      ruby-bundler && \
    gem install rake && \
    gem install ffi -v 1.9.24 && \
    wget -O dirb.tar.gz https://downloads.sourceforge.net/project/dirb/dirb/2.22/dirb222.tar.gz && \
    tar xvf dirb.tar.gz && \
    rm dirb.tar.gz && \
    cd dirb222 && \
    chmod 755 ./configure && \
    ./configure && \
    make && \
    ln -s /opt/dirb222/dirb /usr/local/bin/dirb && \
    gem install gauntlt --no-rdoc --no-ri && \
    apt remove -y \
          ruby-dev \
          python2.7-dev \
          libxml2-dev \
          libxslt1-dev \
          build-essential \
          libcurl4-openssl-dev \
          zlib1g-dev && \
    pip install sslyze==1.3.4 && \
    gem install zapr && \
    rm -rf /var/lib/apt/lists/* && \
    apt autoremove -y && \
    apt clean


# Install remaining Attack tools

# arachni
RUN wget https://github.com/Arachni/arachni/releases/download/v1.5.1/${ARACHNI_VERSION}-linux-x86_64.tar.gz && \
    tar xzvf ${ARACHNI_VERSION}-linux-x86_64.tar.gz > /dev/null && \
    mv ${ARACHNI_VERSION} /usr/local && \
    rm ${ARACHNI_VERSION}-linux-x86_64.tar.gz && \
    ln -s /usr/local/${ARACHNI_VERSION}/bin/* /usr/local/bin/

# Nikto
RUN apt-get update && \
    apt-get install -y libtimedate-perl \
      libnet-ssleay-perl && \
    git clone --depth=1 https://github.com/sullo/nikto.git && \
    cd nikto/program && \
    echo "EXECDIR=/opt/nikto/program" >> nikto.conf && \
    ln -s /opt/nikto/program/nikto.conf /etc/nikto.conf && \
    chmod +x nikto.pl && \
    ln -s /opt/nikto/program/nikto.pl /usr/local/bin/nikto && \
    rm -rf /var/lib/apt/lists/* && \
    apt autoremove -y && \
    apt clean

# sqlmap
ENV SQLMAP_PATH /opt/sqlmap/sqlmap.py
RUN git clone --depth=1 https://github.com/sqlmapproject/sqlmap.git

# dirdb is installed with stuff needing build esentials
ENV DIRB_WORDLISTS /opt/dirb222/wordlists

# nmap
RUN apt update && \
    apt install -y nmap && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean

# sslyze is installed with stuff needing build esentials
ENV SSLYZE_PATH /usr/local/bin/sslyze

# Heartbleed
RUN apt update && \
    apt install -y golang && \
    export GOPATH=/go && \
    go get github.com/FiloSottile/Heartbleed && \
    go install github.com/FiloSottile/Heartbleed && \
    mv /go/bin/Heartbleed /usr/local/bin/ && \
    rm -rf /go && \
    apt remove -y golang && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean

# Garmr
RUN pip install beautifulsoup && \
    git clone https://github.com/freddyb/Garmr.git && \
    cd Garmr && \
    python setup.py install

# owasp-zap adapted from https://github.com/zaproxy/zaproxy/blob/develop/docker/Dockerfile-stable
RUN curl -s https://raw.githubusercontent.com/zaproxy/zap-admin/master/ZapVersions.xml | xmlstarlet sel -t -v //url |grep -i Linux | wget -nv --content-disposition -i - -O - | tar zxv && \
    mv ZAP* zap &&\
	cd zap &&  \
	# Setup Webswing
	curl -s -L https://bitbucket.org/meszarv/webswing/downloads/webswing-2.5.10.zip > webswing.zip && \
	unzip webswing.zip && \
	rm webswing.zip && \
	mv webswing-* webswing && \
	# Remove Webswing demos
	rm -Rf webswing/demo/ && \
	# Accept ZAP license
	touch AcceptedLicense && \
    pip install zapcli python-owasp-zap-v2.4
    

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV PATH $JAVA_HOME/bin:/opt/zap/:$PATH
ENV ZAP_PATH /opt/zap/zap.sh

VOLUME [ "/attacks" ]

ENTRYPOINT [ "/usr/local/bin/gauntlt" ]

CMD ["/attacks/*"]
