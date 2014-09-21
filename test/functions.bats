#!/usr/bin/env bats

load test_helper
source "$BATS_TEST_DIRNAME/../functions.sh"

setup() {
    suffix="(${WERCKER_GIT_COMMIT:0:7}) of $WERCKER_GIT_OWNER/$WERCKER_GIT_REPOSITORY@$WERCKER_GIT_BRANCH by $WERCKER_STARTED_BY"
}

@test "Token undefined" {
    WERCKER_IDOBATA_NOTIFY_TOKEN="" \
    run valid

    [ "$status" -eq 1 ]
    [ "$output" = "Please specify token property." ]
}

@test "Notify skip" {
    WERCKER_IDOBATA_NOTIFY_TOKEN=token \
    WERCKER_IDOBATA_NOTIFY_ON=failed \
    run valid

    [ "$status" -eq 1 ]
    [ "$output" = "Skipping..." ]
}

@test "Build Passed" {
    source="Build <span class=\"label label-success\">passed</span> \
<a href=\"http://example.com/build/1\">#1</a> $suffix"

    WERCKER_IDOBATA_NOTIFY_TOKEN=token \
    WERCKER_BUILD_URL="http://example.com/build/1" \
    WERCKER_BUILD_ID=1 \
    WERCKER_RESULT=passed \
    CI=true \
    run message

    [ "$status" -eq 0 ]
    [ "$output" = "$source" ]
}

@test "Deploy passed" {
    source="Deploy to sandbox <span class=\"label label-success\">passed</span> \
<a href=\"http://example.com/deploy/1\">#1</a> ${suffix}"

    WERCKER_IDOBATA_NOTIFY_TOKEN=token \
    WERCKER_DEPLOY_URL="http://example.com/deploy/1" \
    WERCKER_DEPLOY_ID=1 \
    WERCKER_RESULT=passed \
    WERCKER_DEPLOYTARGET_NAME=sandbox \
    CI="" \
    DEPLOY=true \
    run message

    [ "$status" -eq 0 ]
    [ "$output" = "$source" ]
}

@test "Build failure" {
    source="Build <span class=\"label label-important\">faild</span> \
<a href=\"http://example.com/build/1\">#1</a> ${suffix}"

    WERCKER_IDOBATA_NOTIFY_TOKEN=token \
    WERCKER_BUILD_URL="http://example.com/build/1" \
    WERCKER_BUILD_ID=1 \
    WERCKER_RESULT=faild \
    CI=true \
    run message

    [ "$status" -eq 0 ]
    [ "$output" = "$source" ]
}

@test "Deploy failure" {
    source="Deploy to sandbox <span class=\"label label-important\">faild</span> \
<a href=\"http://example.com/deploy/1\">#1</a> ${suffix}"

    WERCKER_IDOBATA_NOTIFY_TOKEN=token \
    WERCKER_DEPLOY_URL="http://example.com/deploy/1" \
    WERCKER_DEPLOY_ID=1 \
    WERCKER_RESULT=faild \
    WERCKER_DEPLOYTARGET_NAME=sandbox \
    CI="" \
    DEPLOY=true \
    run message

    [ "$status" -eq 0 ]
    [ "$output" = "$source" ]
}
