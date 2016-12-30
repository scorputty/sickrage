#!/usr/bin/env bats

@test "Opening Sickrage on port 8081" {
  run curl -I -s -X GET http://localhost:8081
  [ "$status" -eq 0 ]
}
