FROM java:jre-alpine

MAINTAINER AlgoHub <mike@algohub.com>

RUN apk add --update --no-cache \
	python \
	py-curl \
	git \
	unzip \
	wget \
	bash

# install geturl script to retrieve the most current download URL of CoreNLP
WORKDIR /opt/
RUN git clone https://github.com/foutaise/grepurl.git


# install latest CoreNLP release
RUN wget $(/opt/grepurl/grepurl -r 'zip$' -a http://stanfordnlp.github.io/CoreNLP/) && \
    unzip stanford-corenlp-full-*.zip && \
    mv $(ls -d stanford-corenlp-full-*/) corenlp && rm *.zip

WORKDIR /opt/corenlp

RUN export CLASSPATH="`find . -name '*.jar'`"

ENV PORT 9000
EXPOSE $PORT

ADD . /opt/algorun/

CMD java -Xmx4g -jar /opt/algorun/algo-runner.jar -config /opt/algorun/sample-config.json -kafkaServers 172.27.130.55:32771