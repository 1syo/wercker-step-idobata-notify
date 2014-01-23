if [ ! -n "$WERCKER_IDOBATA_NOTIFY_TOKEN" ]; then
  fail 'Please specify token property.'
fi

if [ "$WERCKER_IDOBATA_NOTIFY_ON" = "failed" ]; then
  info "Skipping..."
  return 0
fi

if [ "$WERCKER_RESULT" = "passed" ]; then
  status="<span class=\"label label-success\">SUCCESS</span>"
else
  status="<span class=\"label label-important\">FAILURE</span>"
fi

if [ "$CI" = "true" ]; then
  step="build"
  id=$WERCKER_BUILD_ID
  url=$WERCKER_BUILD_URL
elif [ "$DEPLOY" = "true" ]; then
  step="deploy"
  id=$WERCKER_DEPLOY_ID
  url=$WERCKER_DEPLOY_URL
else
  step="build"
  id=$WERCKER_BUILD_ID
  url=$WERCKER_BUILD_URL
fi

info "step: $step"
info "id: $id"
info "url: $url"

curl -s \
  --data-urlencode "source=Project $WERCKER_APPLICATION_NAME $step $number, $url: $status" \
  --data "format=html" \
  "https://idobata.io/hook/$WERCKER_IDOBATA_NOTIFY_TOKEN"
