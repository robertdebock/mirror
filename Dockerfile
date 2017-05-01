FROM httpd

LABEL name=mirror
LABEL version=1.1

ENV directory /usr/local/apache2
ENV file conf/extra/httpd-mirror.conf
ENV configfile $directory/$file

EXPOSE 8080 8443

VOLUME /data

RUN apt-get update && \
    apt-get install -y curl openssl && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/* && \
    echo "Include conf/extra/httpd-mirror.conf" >> $directory/conf/httpd.conf

ADD httpd-mirror.conf $configfile

ADD start.sh /start.sh
RUN chmod +x /start.sh

CMD exec /start.sh

HEALTHCHECK CMD curl --fail --insecure https://localhost/ || exit 1
