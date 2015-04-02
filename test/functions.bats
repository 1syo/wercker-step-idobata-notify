#!/usr/bin/env bats

load test_helper
source "$BATS_TEST_DIRNAME/../functions.sh"

setup() {
    repository="$WERCKER_GIT_OWNER/$WERCKER_GIT_REPOSITORY"
    branch="($WERCKER_GIT_BRANCH - ${WERCKER_GIT_COMMIT:0:7})"
    stub git "TAKAHASHI Kazunari: commit message here"
}

teardown() {
    unstub git
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
    source="Build $repository<a href=\"http://example.com/build/1\">#1</a> $branch: <span class=\"label label-success\">PASSED</span><br />TAKAHASHI Kazunari: commit message here"

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
    source="Deploy $repository<a href=\"http://example.com/deploy/1\">#1</a> $branch to sandbox: <span class=\"label label-success\">PASSED</span><br />TAKAHASHI Kazunari: commit message here"

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
    source="Build $repository<a href=\"http://example.com/build/1\">#1</a> $branch: <span class=\"label label-danger\">FAILD</span><br />TAKAHASHI Kazunari: commit message here"

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
    source="Deploy $repository<a href=\"http://example.com/deploy/1\">#1</a> $branch to sandbox: <span class=\"label label-danger\">FAILD</span><br />TAKAHASHI Kazunari: commit message here"

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
