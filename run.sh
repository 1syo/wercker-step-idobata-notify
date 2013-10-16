#!/bin/sh

cmd=`which curl`
if [ ! -n "$cmd" ]; then
  fail 'Command not found.'
fi

if [ ! -n "$WERCKER_IDOBATA_NOTIFY_TOKEN" ]; then
  fail 'Please specify token property.'
fi

if [ "$WERCKER_IDOBATA_NOTIFY_ON" = "failed" ]; then
  if [ "$WERCKER_RESULT" = "passed" ]; then
    info "Skipping..."
    return 0
  fi
fi

if [ ! -n "$WERCKER_IDOBATA_NOTIFY_PASSED_MESSAGE" ]; then
  if [ ! -n "$DEPLOY" ]; then
    passed_message="$WERCKER_APPLICATION_OWNER_NAME/$WERCKER_APPLICATION_NAME: build of $WERCKER_GIT_BRANCH by $WERCKER_STARTED_BY passed."
  else
    passed_message="$WERCKER_APPLICATION_OWNER_NAME/$WERCKER_APPLICATION_NAME: deploy to $WERCKER_DEPLOYTARGET_NAME by $WERCKER_STARTED_BY passed."
  fi
else
  passed_message="$WERCKER_IDOBATA_NOTIFY_PASSED_MESSAGE"
fi

if [ ! -n "$WERCKER_IDOBATA_NOTIFY_FAILED_MESSAGE" ]; then
  if [ ! -n "$DEPLOY" ]; then
    failed_message="$WERCKER_APPLICATION_OWNER_NAME/$WERCKER_APPLICATION_NAME: build of $WERCKER_GIT_BRANCH by $WERCKER_STARTED_BY failed."
  else
    failed_message="$WERCKER_APPLICATION_OWNER_NAME/$WERCKER_APPLICATION_NAME: deploy to $WERCKER_DEPLOYTARGET_NAME by $WERCKER_STARTED_BY failed."
  fi
else
  failed_message="$WERCKER_IDOBATA_NOTIFY_FAILED_MESSAGE"
fi

if [ "$WERCKER_RESULT" = "passed" ]; then
  message="$passed_message"
else
  message="$failed_message"
fi
info "$message"

$cmd -X POST -s --data-urlencode "body=$message" "https://idobata.io/hook/$WERCKER_IDOBATA_NOTIFY_TOKEN" > /dev/null
