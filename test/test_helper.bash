export PATH="$BATS_TEST_DIRNAME/..:$PATH"

if [ ! -n "$WERCKER" ]; then
    export WERCKER_APPLICATION_ID="5253e1053673929130009361"
    export WERCKER_APPLICATION_NAME="wercker-step-idobata-notify"
    export WERCKER_APPLICATION_OWNER_NAME="1syo"
    export WERCKER_APPLICATION_URL="https://app.wercker.com/#applications/5253e1053673929130009361"
    export WERCKER_GIT_DOMAIN="github.com"
    export WERCKER_GIT_OWNER="1syo"
    export WERCKER_GIT_REPOSITORY="wercker-step-idobata-notify"
    export WERCKER_GIT_BRANCH="master"
    export WERCKER_GIT_COMMIT="0202384f181758213525b55e077c4079276f3f70"
    export WERCKER_STARTED_BY="1syo"
    export WERCKER_STEP_TEMP=$BATS_TMPDIR
fi

success() {
    echo $1
    exit 0
}

fail() {
    echo $1
    exit 1
}

info() {
    echo $1
}

export -f success
export -f fail
export -f info

stub() {
    local cmd=$1
    local ret=$2
    eval "$(echo -e "${cmd}() {\n echo $ret\n}")"
    export -f ${cmd}
}

unstub() {
    local cmd=$1
    unset -f "$cmd"
}
