valid() {
    if [ ! -n "$WERCKER_IDOBATA_NOTIFY_TOKEN" ]; then
        echo 'Please specify token property.'
        exit 1
    fi

    if [ "$WERCKER_IDOBATA_NOTIFY_ON" = "failed" ]; then
        echo "Skipping..."
        exit 1
    fi
    exit 0
}

message() {
    repository="$WERCKER_GIT_OWNER/$WERCKER_GIT_REPOSITORY@$WERCKER_GIT_BRANCH"
    commit=${WERCKER_GIT_COMMIT:0:7}
    commiter="$WERCKER_STARTED_BY"

    if [ "$WERCKER_RESULT" = "passed" ]; then
        build_result="<span class=\"label label-success\">$WERCKER_RESULT</span>"
    else
        build_result="<span class=\"label label-important\">$WERCKER_RESULT</span>"
    fi

    if [ "$DEPLOY" = "true" ]; then
        job_information="<a href=\"$WERCKER_DEPLOY_URL\">#$WERCKER_DEPLOY_ID</a> ($commit)"
        echo "Deploy to $WERCKER_DEPLOYTARGET_NAME $build_result $job_information of $repository by $commiter"
        # ex: Deploy to sandobox passed #13402 (799877b) of 1syo/wercker-step-idobata-notify@master by TAKAHASHI Kazunari
    fi

    if [ "$CI" = "true" ]; then
        job_information="<a href=\"$WERCKER_BUILD_URL\">#$WERCKER_BUILD_ID</a> ($commit)"
        echo "Build $build_result $job_information of $repository by $commiter"
        # ex: Build broken #13402 (799877b) of 1syo/wercker-step-idobata-notify@master by TAKAHASHI Kazunari
    fi

    exit 0
}
