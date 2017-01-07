#!/usr/bin/env bats

@test "Opening Sickrage on port 8081" {
  skip
  curl -I -s -X GET http://localhost:8081 |grep 302
  [ "$status" -eq 0 ]
}
