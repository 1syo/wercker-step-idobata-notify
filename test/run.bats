#!/usr/bin/env bats

load test_helper

@test "Hoge" {
    PATH="test/bin:$PATH"
    run ./run.sh
    [[ ${lines[0]} =~ "finished" ]]
}
