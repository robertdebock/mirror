#!/usr/bin/env bats

@test "Building the image." {
  run docker build -t mirror .
  [ "${status}" -eq 0 ]
}

@test "Starting the container without required arguments." {
  run docker run --rm mirror
  [ "${status}" -ne 0 ]
}

@test "Starting the container with required arguments." {
  run docker run --rm -p 8443:443 -d -e "externalurl=https://www.flickr.com/photos/robertdebock" --name "mirror" mirror
  [ "${status}" -eq 0 ]
}

@test "Waiting 3 seconds for the container to start." {
  run sleep 3
  [ "${status}" -eq 0 ]
}

@test "Getting page https://localhost:8443/ ." {
  run curl --insecure --fail https://localhost:8443/
  [ "${status}" -eq 0 ]
}

@test "Stopping container." {
  run docker kill mirror 
  [ "${status}" -eq 0 ]
}
