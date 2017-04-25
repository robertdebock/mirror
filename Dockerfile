FROM httpd

ENV directory    /usr/local/apache2
ENV file conf/extra/httpd-any.conf
ENV configfile   $directory/$file

EXPOSE 8080

# Load all required modules.
RUN echo "LoadModule proxy_module modules/mod_proxy.so" >> $configfile && \
    echo "LoadModule proxy_http_module modules/mod_proxy_http.so" >> $configfile && \
    echo "LoadModule ssl_module modules/mod_ssl.so" >> $configfile && \
    echo "LoadModule proxy_html_module modules/mod_proxy_html.so" >> $configfile && \
    echo "LoadModule xml2enc_module modules/mod_xml2enc.so" >> $configfile && \
    echo "Include conf/extra/proxy-html.conf" >> $configfile && \
    echo "" $configfile

# Include all required settings
RUN echo "Include conf/extra/httpd-any.conf" >>  $directory/conf/httpd.conf

# Enable SSL
#RUN echo "Include conf/extra/httpd-ssl.conf" > $directory/conf/extra/httpd-ssl.conf

# Write the custom configuration file.
CMD echo "SSLProxyEngine on" >> $configfile && \
    echo "<Location \"/\">" >> $configfile && \
    echo "  ProxyPass ${externalurl}" >> $configfile && \
    echo "  ProxyPassReverse ${externalurl}" >> $configfile && \
    echo "</Location>" >> $configfile && \
    exec httpd-foreground
