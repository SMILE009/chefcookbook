#!/usr/bin/env bats

@test "ntpd binary is found in PATH" {
  run which ntpd
  [ "$status" -eq 0 ]
}
