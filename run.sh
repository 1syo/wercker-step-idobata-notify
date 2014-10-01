source "$WERCKER_STEP_ROOT/functions.sh"

error_message=$(valid)
if [ $? = 1 ]; then
    warn "$error_message"
    exit 0
fi

http_code=`curl \
    --silent \
    --data "format=html" \
    --data-urlencode "source=$(message)" \
    --output "$WERCKER_STEP_TEMP/result.txt" \
    --write-out "%{http_code}" \
    "https://idobata.io/hook/$WERCKER_IDOBATA_NOTIFY_TOKEN"`

if [ "$http_code" = "200" ]; then
    success "Finished successfully!"
else
    warn `cat $WERCKER_STEP_TEMP/result.txt`
    warn "Finished unsuccessfully."
fi
