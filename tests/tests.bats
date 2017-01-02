#!/usr/bin/env bats

@test "Opening Sickrage on port 8081" {
  curl -sk http://localhost:8081
}
