@test "Opening Sickrage on port 8081" {
  run curl http://localhost:8081
  [ "${status}" -eq 0 ]
}
