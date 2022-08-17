# Use a Oracle JDK base image
FROM committed/java
MAINTAINER Dstl <https://github.com/dstl/baleen>

# Baleen installation and configuration
ENV BALEEN_VERSION 3.1.1
ENV ANNOT8_VERSION 1.2.0

# make the directories we'll need.
# baleen can create these by default, but the components one isn't
RUN mkdir -p /baleen/components && mkdir -p /baleen/pipelines && mkdir -p /baleen/templates

# installed components must be in the components directory.
# I have found models help to be in the components directory too. They seem to work better 
# with their component code. It is possible to specify a different model path, but why make it harder?

# let's install some components like openNLP, openCV might be good, 
# these components are annot8 components https://github.com/annot8/annot8-components/releases
RUN wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-annotations-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-audio-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-base-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-base-text-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-comms-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-cyber-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-db-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-documents-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-elasticsearch-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-files-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-financial-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-gazetteers-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-geo-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-grouping-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-groups-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-image-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-items-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-kafka-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-mongo-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-opencv-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-opennlp-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-people-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-print-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-properties-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-quantities-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-social-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-spacy-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-stopwords-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-temporal-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-tesseract-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-text-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-tika-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-translation-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-types-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-vehicles-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-components-wordnet-${ANNNOT8_VERSION}-plugin.jar \
    && wget -q -P /baleen/components/ https://github.com/annot8/annot8-components/releases/download/v${ANNNOT8_VERSION}/annot8-utils-text-${ANNNOT8_VERSION}-plugin.jar


# Download the (English) OpenNLP Name Entity Recognition models
RUN mkdir -p /baleen/components \
 && wget -q -P /baleen/components/ http://opennlp.sourceforge.net/models-1.5/en-ner-date.bin \
 && wget -q -P /baleen/components/ http://opennlp.sourceforge.net/models-1.5/en-ner-location.bin \
 && wget -q -P /baleen/components/ http://opennlp.sourceforge.net/models-1.5/en-ner-money.bin \
 && wget -q -P /baleen/components/ http://opennlp.sourceforge.net/models-1.5/en-ner-organization.bin \
 && wget -q -P /baleen/components/ http://opennlp.sourceforge.net/models-1.5/en-ner-percentage.bin  \
 && wget -q -P /baleen/components/ http://opennlp.sourceforge.net/models-1.5/en-ner-person.bin \
 && wget -q -P /baleen/components/ http://opennlp.sourceforge.net/models-1.5/en-ner-time.bin
 
 # Let's download the newer OpenNLP models we might need them too...
 
RUN mkdir -p /baleen/components \
 && wget -q -P /baleen/components/ https://www.apache.org/dyn/closer.cgi/opennlp/models/langdetect/1.8.3/langdetect-183.bin \
 && wget -q -P /baleen/components/ https://www.apache.org/dyn/closer.cgi/opennlp/models/ud-models-1.0/opennlp-en-ud-ewt-sentence-1.0-1.9.3.bin \
 && wget -q -P /baleen/components/ https://www.apache.org/dyn/closer.cgi/opennlp/models/ud-models-1.0/opennlp-en-ud-ewt-pos-1.0-1.9.3.bin \
 && wget -q -P /baleen/components/ https://www.apache.org/dyn/closer.cgi/opennlp/models/ud-models-1.0/opennlp-en-ud-ewt-tokens-1.0-1.9.3.bin \
 && wget -q -P /baleen/components/ http://opennlp.sourceforge.net/models-1.5/en-ner-percentage.bin  \
 && wget -q -P /baleen/components/ http://opennlp.sourceforge.net/models-1.5/en-ner-person.bin \
 && wget -q -P /baleen/components/ http://opennlp.sourceforge.net/models-1.5/en-ner-time.bin
 

# Now create the necessary directories (/baleen used as a volume, /opt/baleen for the jars):

# Either, download the Jars direct from github releases
RUN mkdir -p /baleen \
 && wget -q -P /baleen/ https://github.com/dstl/baleen3/releases/download/v${BALEEN_VERSION}/baleen-${BALEEN_VERSION}.jar 
 
 
# && wget -q -P /baleen/ https://github.com/dstl/baleen/releases/download/v${BALEEN_VERSION}/baleen-${BALEEN_VERSION}-javadoc.jar
 
 
# Or, if you have a local version you can comment out the wget above
# and use the ADD line instead.
# ADD baleen-${BALEEN_VERSION}.jar /opt/baleen/baleen.jar
# ADD baleen-${BALEEN_VERSION}-javadoc.jar /opt/baleen/baleen-javadoc.jar

# Mount /baleen as the working directory, expose the Baleen's standard port
VOLUME /baleen
WORKDIR /baleen
EXPOSE 6413

# Always run Baleen
ENTRYPOINT ["java", "-jar", "/baleen/baleen.jar"]
