FROM httpd:2.4.25

LABEL name=mirror
LABEL version=1.2

ENV DIRECTORY /usr/local/apache2
ENV FILE conf/extra/httpd-mirror.conf
ENV CONFIGFILE $DIRECTORY/$FILE

EXPOSE 80 443

VOLUME /data

ADD httpd-mirror.conf $CONFIGFILE
ADD start.sh /start.sh

RUN apt-get update && \
    apt-get install -y
      curl \
      openssl && \
    rm -rf /var/lib/apt/lists/* && \
    echo "Include conf/extra/httpd-mirror.conf" >> $DIRECTORY/conf/httpd.conf && \
    chmod +x /start.sh

CMD exec /start.sh

HEALTHCHECK CMD curl --fail --insecure https://localhost/ || exit 1
