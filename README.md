# Custom URL for any website
[![Build Status](https://travis-ci.org/robertdebock/mirror.svg?branch=master)](https://travis-ci.org/robertdebock/mirror)
With this application you can mirror any IP or URL to an existing website. This may be useful to:
- Hook a personal domain to some service like Flickr.
- Allow visitors to see a website banned through regular channels.

## Overview
````
+----------+    +------------------+    +------------------+
| Internet | -> | This application | -> | Existing website |
|          | -> | Docker container | -> | https://bla.com  |
+----------+    +------------------+    +------------------+
````

## TL;DR
Run it like this:
````
docker run -p 8443:443 -e "externalurl=https://www.flickr.com/photos/robertdebock" robertdebock/custom-url
````

### Mandatory parameters
- -p 8443:443 - Map host (external) TCP port to the container. In this case TCP port 8443 can be accessed by visitors and it's mapped to TP port 443 inside the container. Port 80 is also available in the container, serving the same content.
- -e "externalurl=https://www.flickr.com/photos/robertdebock" - Setup the (Apache) proxy to map a custom URL to https://www.flickr.com/photos/robertdebock. It's best to (try to) open the website in a browser, let all redirects take place and use the final URL.

### Optional parameters
- -v $(pwd)/data:/data - Map the volume "./data" to /data. This is the place where keys and certificates are expected, with this exact naming: server.key for the SSL Key, server.crt for the SSL Certificate.
- -e "cn=example.com" - Set the common name to "example.com". Used for the SSL Certificate and the Apache ServerName.
