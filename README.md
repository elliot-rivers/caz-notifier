do an ol `bundle install`

then leave this running in a term somewhere:

`bundle exec ruby bin/caz_monitor.rb`

it'll check for CAZ requests every 15 seconds and push you desktop notifications about it.

click the notification and it'll open up the review website

acknowledged deficiencies:
* i'm not great a ruby
    * but this was an opportunity to learn some more stuff
* i have tried to limit the garbage but it may fill your notification center with nonsense
* unless you change the code, i don't expose the ability to change the refresh interval
* uses system calls to `curl` instead of native ruby http requests library (see bullet 1)
    * mostly i couldn't figure out cookies
* I probably don't cover every edge-case for error handling
* no tests
* no gemspec
* no rake anything nor other perhaps canonical infrastructure

submit a PR if you have issues
