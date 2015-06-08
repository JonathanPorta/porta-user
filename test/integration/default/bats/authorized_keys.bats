#!/usr/bin/env bats

@test "portaj user exists" {
  result="$(grep -c '^portaj:' /etc/passwd)"
  [ "$result" -eq 1 ]
}

@test "portaj user has an authorized keys file" {
  result="$(cat /home/portaj/.ssh/authorized_keys | wc -l)"
  [ "$result" -eq 6 ]
}
