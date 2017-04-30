#!/usr/bin/env bats

@test "Getting page https://localhost:8443/ ." {
  run curl --insecure --fail https://localhost:8443/
  [ "${status}" -eq 0 ]
}
