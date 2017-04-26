FROM httpd

ENV directory /usr/local/apache2
ENV file conf/extra/httpd-any.conf
ENV configfile $directory/$file

EXPOSE 8080 8443

VOLUME /data

ADD start.sh /start.sh

RUN apt-get update && \
    apt-get install -y openssl && \
    rm -rf /var/lib/apt/lists/* && \
    echo "LoadModule proxy_module modules/mod_proxy.so" >> $configfile && \
    echo "LoadModule proxy_http_module modules/mod_proxy_http.so" >> $configfile && \
    echo "LoadModule ssl_module modules/mod_ssl.so" >> $configfile && \
    echo "LoadModule socache_shmcb_module modules/mod_socache_shmcb.so" >> $configfile && \
    echo "LoadModule proxy_html_module modules/mod_proxy_html.so" >> $configfile && \
    echo "LoadModule xml2enc_module modules/mod_xml2enc.so" >> $configfile && \
    echo "Include conf/extra/proxy-html.conf" >> $configfile && \
    echo "Include conf/extra/httpd-ssl.conf" >> $configfile && \
    echo "ServerName ${cn:-localhost}" >> $configfile && \
    echo "Include conf/extra/httpd-any.conf" >>  $directory/conf/httpd.conf && \
    chmod +x /start.sh

CMD exec /start.sh
