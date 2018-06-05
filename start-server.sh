#!/bin/bash
cd /opt/corenlp
export CLASSPATH="`find . -name '*.jar'`"
java -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer --port 9000 --timeout 10000