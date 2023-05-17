
CSV_SEPARATOR=';' \
	&& RUN_DATETIME=$(date +"%Y-%m-%d_%H.%M.%S") \
	&& OUTPUT_DIR="results_$RUN_DATETIME" \
	&& RUN_FILENAME="$OUTPUT_DIR/url_statuscodes_$RUN_DATETIME.csv" \
	&& mkdir -p $OUTPUT_DIR \
	&& echo -n '' > $RUN_FILENAME \
	&& tail -c 1 urls.txt | read || echo >> urls.txt \
	&& URLS=`cat urls.txt` \
	&& AMOUNT_URLS=$(cat urls.txt | wc -l) \
	&& INDEX=0 \
	&& for URL in $URLS; do \
		INDEX=$((INDEX+1)) \
		&& echo -n "[$INDEX/$AMOUNT_URLS] $URL > " \
		&& mkdir -p $OUTPUT_DIR/details \
		&& echo -n "${URL}${CSV_SEPARATOR}" >> $RUN_FILENAME \
		&& FILENAME=$(echo $URL | sed -e 's|http://|http~|I' | sed -e 's|https://|https~|I' | sed -e 's|[^a-zA-Z0-9\_\.\-\/\~]|-|g' | sed -e 's|[\/]|~|g') \
		&& NOW=$(date +"%Y-%m-%d_%H.%M.%S") \
		&& PATH_URL="$OUTPUT_DIR/details/$NOW.$FILENAME.url.txt" \
		&& PATH_HEADERS="$OUTPUT_DIR/details/$NOW.$FILENAME.headers.txt" \
		&& PATH_BODY="$OUTPUT_DIR/details/$NOW.$FILENAME.body.html" \
		&& echo -n $URL > $PATH_URL \
		&& curl --output $PATH_BODY --dump-header $PATH_HEADERS --max-redirs 20 --max-time 20 --retry 3 --location --fail --silent $URL \
		&& RESULTS=$(cat $PATH_HEADERS | grep -Ei '^http\/|^location\:' | sed -e ':a;N;$!ba;s/\n/| /g' | sed -e 's/\s\+/ /g') \
		&& echo -n $RESULTS >> $RUN_FILENAME \
		&& echo "" >> $RUN_FILENAME \
		&& echo $RESULTS | sed -e 's/\s\+/ /g' \
		; done \
	&& echo -e "\ndone: $RUN_FILENAME\n\n"


# Note: This line makes sure the urls.txt ends with a newline (for counting)
# tail -c 1 urls.txt | read || echo >> urls.txt
