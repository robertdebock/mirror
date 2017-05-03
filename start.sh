#!/bin/sh

if [ ! "${URL}" ] ; then
  echo "ERROR: You need to set the url to mirror using the \"\$URL\" variable!"
  exit 1
fi

# Keys can be available by a persistent data in /data or through a mount.
if [ ! -f /data/server.key ] || [ ! -f /data/server.crt ] ; then
  # If keys are not available, generate them.
  echo "WARNING: Generating SSL Key and Certificate, because none were found."
  openssl req -x509 -newkey rsa:4096 -keyout /data/server.key -out /data/server.crt -days 365 -subj "/CN=${DOMAIN:-localhost}" -nodes
fi

# The persisted, mounted or generated keys should be made available in the default directory.
echo "INFO: Linking SSL Key and Certificate to the runtime location."
ln -s /data/server.key "${DIRECTORY}"/conf/server.key
ln -s /data/server.crt "${DIRECTORY}"/conf/server.crt

# Write a configfile.
echo "INFO: Writing the custom Apache HTTPD configuration."
echo "ServerName ${DOMAIN:-localhost}" >> "${DIRECTORY}"/conf/httpd.conf && \
cat << EOF >> "${CONFIGFILE}"
SSLProxyEngine on

<Location "/">
  ProxyPass ${URL}
  ProxyPassReverse ${URL}
</Location>
EOF

# Start the httpd daemon.
echo "INFO: Staring Apache HTTPD daemon."
exec httpd-foreground
