# Custom URL for any website
With this application you can bind any URL to an existing website. AKA mirror or mirroring. Just run this reverse proxy with the correct parameters.

## TL;DR
Run it like this:
````
docker run -p 8443:443 -e "externalurl=https://www.flickr.com/photos/robertdebock" robertdebock/custom-url
````

### Mandatory parameters
- -p 8443:443 - Map host (external) TCP port to the container. In this case TCP port 8443 can be accessed by visitors and it's mapped to TP port 443 inside the container.
- -e "externalurl=https://www.flickr.com/photos/robertdebock" - Setup the (Apache) proxy to map a custom URL to https://www.flickr.com/photos/robertdebock.

### Optional parameters
- -v $(pwd)/data:/data - Map the volume "./data" to /data. This is the place where keys and certificates are expected, with this exact naming: server.key for the SSL Key, server.crt for the SSL Certificate.
- -e "cn=example.com" - Set the common name to "example.com". Used for the SSL Certificate.
