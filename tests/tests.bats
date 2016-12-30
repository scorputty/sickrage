#!/usr/bin/env bats

@test "Opening Sickrage on port 8081" {
  skip
  run curl -I -s -X GET http://localhost:8081
  [ "$status" -eq 0 ]
}
