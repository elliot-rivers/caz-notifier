# Setup
do an ol `bundle install`

then leave this running in a term somewhere:

`bundle exec ruby bin/caz_monitor.rb`

all options:
```
caz_monitor.rb [options]
    -t, --refresh_interval SECONDS   number of seconds to wait between refresh loops (default 15)
    -u, --ignore-username NAME       a username to ignore alerts for (probably your own)
    -r, --region REGION              your preferred aws region (default: us-east-1)
    -h, --help                       Prints this help
```

it'll check for CAZ requests every 15 seconds and push you desktop notifications about different events.

kill it with ctrl-c

# When do i get notified?

* Once on startup to test that notifications are working
    * if you do not see this notification, see the troubleshooting section
* When a new CAZ request comes through for the team
    * you can click on the notification to open up the review in your browser
* When your CAZ requests are approved
* When your `mwinit` posture expires
    * The program will wait for you to go run mwinit and come back to the terminal continue

# Troubleshooting

## I'm not getting notifications
MacOS system settings are not permitting them, probably. 

Go to: `System Settings` > `Notifications` > `Application Notifications` > `terminal-notifier`

Make sure the toggle is turned on and the type of notifications you want to see are enabled.

# acknowledged deficiencies
* the Chirp CAZ team is hard-coded in there so this is not a general tool
* i'm not great at ruby
    * but this was an opportunity to learn some more stuff
* i have tried to limit the garbage but it may fill your notification center with nonsense
* uses system calls to `curl` instead of native ruby http requests library (see bullet 1)
    * mostly i couldn't figure out cookies
* I probably don't cover every edge-case for error handling
* no tests
* no gemspec
* no rake anything nor other perhaps canonical infrastructure

submit a PR if you have issues
