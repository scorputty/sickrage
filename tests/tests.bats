#!/usr/bin/env bats

@test "Opening Sickrage on port 8081" {
  curl --output /dev/null -I -s -X GET http://localhost:8081
}
