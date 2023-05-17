# Url checker with bash & curl

- Collects status codes (+redirects) in CSV
- Collects headers for each url
- Collects body for each url

# Setup
```
git clone git@github.com:rboonzaijer/urlchecker-bash-curl.git

cd urlchecker-bash-curl

chmod +x check.sh

[ ! -f urls.txt ] && cp examples/urls.example.txt urls.txt


# NOTE: Set your own urls in 'urls.txt'
```

# Run
```
./check.sh
```

# Results

## For each run

- /results_{datetime_started}/url_statuscodes_{datetime_started}.csv

![](examples/example-csv.png)

## For each url

- /results_{datetime_started}/details/{datetime_now}.{url_slug}.body.html (contains the HTML body)
- /results_{datetime_started}/details/{datetime_now}.{url_slug}.headers.txt (contains all headers)
- /results_{datetime_started}/details/{datetime_now}.{url_slug}.url.txt (the original url)

![](examples/example-details.png)
