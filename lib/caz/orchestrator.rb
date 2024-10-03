require 'json'
require 'terminal-notifier'

module Caz
  class Orchestrator
    def initialize(check_interval: 15, region: 'us-east-1', ignore_username: nil)
      @check_interval = check_interval
      @region = region
      @notifier = Notifier.new(ignore_username: ignore_username)
    end

    def run
      notifier.alert('wooooooohoooooo', 'Starting up CAZ notifier')
      while true
        begin
          # one monitor per mwinit
          monitor = Monitor.new(region: region)

          while true
            reviews = monitor.check_for_reviews
            notifier.alert_for_reviews reviews

            sleep check_interval
          end
        rescue Caz::MWInitFailure
          notifier.alert('Check your Midway posture!', 'You need to rerun mwinit -- check the terminal for more info')
          puts "Looks like you aren't Midway authenticated -- run `mwinit` somewhere and come back here"
          puts "press <return> after you've run mwinit"
          gets
        end
      end
    end

    attr_reader :notifier, :check_interval, :region, :ignore_username

    protected
  end
end
