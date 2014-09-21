#!/usr/bin/env bats
load test_helper

@test "Token undefined" {
    WERCKER_IDOBATA_NOTIFY_TOKEN="" \
    run run.sh

    [ "$status" = "0" ]
    [ "$output" = "Please specify token property." ]
}

@test "Send a message" {
    stub curl 200

    WERCKER_IDOBATA_NOTIFY_TOKEN=token \
    WERCKER_RESULT="passed" \
    CI=true \
    run run.sh

    [ "$status" = "0" ]
    [ "$output" = "Finished successfully!" ]
    unstub curl
}

@test "Can not send a message" {
    echo "Error"  > "$WERCKER_STEP_TEMP/result.txt"
    stub curl 500

    WERCKER_IDOBATA_NOTIFY_TOKEN=token \
    WERCKER_RESULT="passed" \
    CI=true \
    run run.sh

    [ "$status" = "0" ]
    [ "${lines[0]}" = "Error" ]
    [ "${lines[1]}" = "Finished unsuccessfully." ]
    unstub curl

    rm "$WERCKER_STEP_TEMP/result.txt"
}
