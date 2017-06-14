#!/usr/bin/env bats

@test "Testing Flickr mirror." {
  run curl --insecure --fail https://localhost:8443/
  [ "${status}" -eq 0 ]
}

@test "Testing Wordpress mirror." {
  run curl --insecure --fail https://localhost:8444/
  [ "${status}" -eq 0 ]
}

@test "Testing Tumblr mirror." {
  run curl --insecure --fail https://localhost:8445/
  [ "${status}" -eq 0 ]
}

@test "Testing The Pirate Bay." {
  run curl --insecure --fail https://localhost:8446/
  [ "${status}" -eq 0 ]
}
