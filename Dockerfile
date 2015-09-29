FROM debian:jessie
MAINTAINER Kolja Dummann <kolja.dummann@logv.ws>
RUN apt-get update 
RUN apt-get install -y openjdk-7-jdk \
	ant \
	build-essential \
	g++ \
	gcc \
	flex \
	bison \
	make \
	subversion \
	libz-dev \
	libwww-perl \
	patch \
	gdb \
	unzip \
	wget \
	git
RUN apt-get autoremove
RUN cd /tmp && \
	wget https://github.com/aktau/github-release/releases/download/v0.6.2/linux-amd64-github-release.tar.bz2 && \
	tar -xjvf linux-amd64-github-release.tar.bz2 && \
	mv bin/linux/amd64/github-release /usr/bin/ && \
	rm -rf bin/
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
