#!/bin/sh

# Keys can be available by a persistent data in /data or through a mount.
if [ ! -f /data/server.key -o ! -f /data/server.crt ] ; then
  # If keys are not available, generate them.
  openssl req -x509 -newkey rsa:4096 -keyout /data/server.key -out /data/server.crt -days 365 -subj "/CN=${cn:-localhost}" -nodes
fi

# The persisted, mounted or generated keys should be made available in the default directory.
ln -s /data/server.key $directory/conf/server.key
ln -s /data/server.crt $directory/conf/server.crt

# Write a configfile.
echo "SSLProxyEngine on" >> $configfile
echo "<Location \"/\">" >> $configfile
echo "  ProxyPass ${externalurl}" >> $configfile
echo "  ProxyPassReverse ${externalurl}" >> $configfile
echo "</Location>" >> $configfile

# Start the httpd daemon.
exec httpd-foreground
