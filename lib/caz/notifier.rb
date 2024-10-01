require 'json'
require 'terminal-notifier'

module Caz
  class Notifier

    def initialize
      # an attempt to auto-close notifications that are no longer applicable
      @active_notifications = {}
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
      TerminalNotifier.remove(id)
      TerminalNotifier.notify(
        "#{review['requester']} needs your help!",
        {
          subtitle: 'New CAZ Request!',
          open: "https://consensus.a2z.com/reviews/#{id}"
        }
      )
      active_notifications[id] = review
    end

    def garbage_collect(reviews)
      ids = reviews.map { |r| r['reviewId'] }
      orphans = active_notifications.keys.to_set - ids.to_set
      orphans.each do |yeet|
        active_notifications.delete yeet
        TerminalNotifier.remove yeet
      end
    end

    attr_reader :active_notifications
  end
end
