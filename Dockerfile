FROM debian:jessie
MAINTAINER Kolja Dummann <kolja.dummann@logv.ws>
ADD ./backports.list /etc/apt/sources.list.d/backports.list
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y openjdk-8-jdk \
	ant \
	build-essential \
	bison \
	ca-certificates \
	curl \
	flex \
	g++ \
	gcc \
	gdb \
	git \
	libz-dev \
	libwww-perl \
	libxerces-c-dev \
	make \
	g++-multilib \
	libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386 \
	patch \
	subversion \
	unzip \
	wget \
	xvfb \
	zip

RUN apt-get autoremove
RUN cd /tmp && \
	wget https://github.com/aktau/github-release/releases/download/v0.6.2/linux-amd64-github-release.tar.bz2 && \
	tar -xjvf linux-amd64-github-release.tar.bz2 && \
	mv bin/linux/amd64/github-release /usr/bin/ && \
	rm -rf bin/

RUN \
	cmake_major_minor=3.7 && \
	cmake=cmake-${cmake_major_minor}.1-Linux-x86_64 && \
	cd /tmp && \
	wget https://cmake.org/files/v${cmake_major_minor}/${cmake}.tar.gz && \
	tar -xzvf ${cmake}.tar.gz && \
	cp -R ${cmake}/bin ${cmake}/share /usr && \
	rm -rf ${cmake} ${cmake}.tar.gz

RUN mkdir /buildAgent && cd /buildAgent && \
	wget https://build.mbeddr.com/update/buildAgent.zip && \
	unzip buildAgent.zip && \
	chmod +x /buildAgent/bin/agent.sh
ADD ./buildAgent.properties /buildAgent/conf/buildAgent.properties
ADD ./start.sh /start
RUN mkdir -p /root/.ssh
ADD ./sshconfig /root/.ssh/config
RUN chmod +x /start
VOLUME ["/build"]
ENTRYPOINT ["/start"]
COPY ./bin/* /usr/bin/
RUN chmod +x /usr/bin/*
