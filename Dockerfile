FROM java:jre-alpine

LABEL maintainer="mike@algohub.com"

RUN apk add --update --no-cache \
	python \
	py-curl \
	git \
	unzip \
	wget \
	bash

# install grepurl script to retrieve the most current download URL of CoreNLP
WORKDIR /opt/
RUN git clone https://github.com/foutaise/grepurl.git


# install latest CoreNLP release
RUN wget $(/opt/grepurl/grepurl -r 'zip$' -a http://stanfordnlp.github.io/CoreNLP/) && \
    unzip stanford-corenlp-full-*.zip && \
    mv $(ls -d stanford-corenlp-full-*/) corenlp && rm *.zip

ADD . /opt/algorun/

#EXPOSE 9000

RUN chmod +x /opt/algorun/start-server.sh

WORKDIR /opt/algorun/

ENTRYPOINT ["/opt/algorun/algo-runner-go"]