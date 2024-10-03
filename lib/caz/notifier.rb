require 'json'
require 'terminal-notifier'

module Caz
  class Notifier
    def initialize(ignore_username: nil)
      # an attempt to auto-close notifications that are no longer applicable
      @active_notifications = {}
      @ignore_username = ignore_username
    end

    def alert_for_reviews(reviews)
      # clean up irrelevant reviews
      garbage_collect reviews
      # submit notifs for new ones
      reviews.each do |review|
        create_notification review
      end
      puts "notified for #{reviews.length} reviews"
    end

    def create_notification(review)
      id = review['reviewId']
      active_notifications[id] = review
      return if review['requester'] == ignore_username

      TerminalNotifier.remove(id)
      TerminalNotifier.notify(
        "#{review['requester']} needs your help!",
        {
          subtitle: 'New CAZ Request!',
          open: "https://consensus.a2z.com/reviews/#{id}"
        }
      )
    end

    def alert(message, subtitle)
      TerminalNotifier.notify(
        message,
        {
          subtitle: subtitle
        }
      )
    end

    def garbage_collect(reviews)
      ids = reviews.map { |r| r['reviewId'] }
      orphans = active_notifications.keys.to_set - ids.to_set
      orphans.each do |yeet|
        if active_notifications[yeet]['requester'] == ignore_username
          TerminalNotifier.notify(
            'Your review has been approved!',
            {subtitle: 'WOOOOOOOooooooHOOOooooo!'}
          )
        end
        active_notifications.delete yeet
        TerminalNotifier.remove yeet
      end
    end

    attr_reader :active_notifications, :ignore_username
  end
end
