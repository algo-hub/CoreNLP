FROM java:jre-alpine

MAINTAINER AlgoHub <mike@algohub.com>

RUN apk add --update --no-cache \
	python \
	py-curl \
	git \
	unzip \
	wget

# install geturl script to retrieve the most current download URL of CoreNLP
WORKDIR /opt/
RUN git clone https://github.com/foutaise/grepurl.git


# install latest CoreNLP release
RUN wget $(/opt/grepurl/grepurl -r 'zip$' -a http://stanfordnlp.github.io/CoreNLP/) && \
    unzip stanford-corenlp-full-*.zip && \
    mv $(ls -d stanford-corenlp-full-*/) corenlp && rm *.zip

WORKDIR /opt/corenlp

ENV PORT 9000
EXPOSE $PORT

RUN export CLASSPATH="`find . -name '*.jar'`"

CMD java -mx4g -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer --port $PORT --timeout 10000