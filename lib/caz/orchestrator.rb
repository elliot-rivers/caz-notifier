require 'json'
require 'terminal-notifier'

module Caz
  class Orchestrator
    def initialize(check_interval: 15)
      @check_interval = check_interval
      @notifier = Notifier.new
    end

    def run
      notifier.alert('wooooooohoooooo', 'Starting up CAZ notifier')
      while true
        begin
          # one monitor per mwinit
          monitor = Monitor.new

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

    attr_reader :notifier, :check_interval

    protected
  end
end
