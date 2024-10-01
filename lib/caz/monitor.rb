require 'json'

module Caz
  class MWInitFailure < StandardError; end

  class Monitor

    def initialize
      # RAII, baby
      @token = csrf_token
    end

    def check_for_reviews
      # return a list of reviews that need approvals
      # TODO actually handle pagination
      #   but also if there's more than ten, they'll be picked up after some are handled :Shrug:
      raw = `curl -s --location-trusted -c ~/.midway/cookie -b ~/.midway/cookie -X POST -H "Accept: application/json" \
             --data-raw '{"maxResults":10,\
                          "reviewer": "teammember-amzn1.abacus.team.4vnbgkzcx5fklot4qyta",
                          "reviewStatus": "OPEN"}' -H "X-CSRF-token: #{token}"\
             -b "CSRF-TOKEN=#{token}" 'https://api.us-east-1.consensus.a2z.com/v2/listReviews'`
      JSON.parse(raw).fetch 'reviews'
    rescue
      raise MWInitFailure, 'Looks like mwinit expired'
    end

    attr_reader :token

    protected

    def csrf_token
      # yeah yeah sure i could use actual ruby http calls but :shrug: this works
      raw = `curl -s --location-trusted -L --cookie-jar ~/.midway/cookie --cookie ~/.midway/cookie \
             -H "Content-Type: application/json" https://api.us-east-1.consensus.a2z.com/v2/getUserInfo -c -`

      raise MWInitFailure, 'You are not authenticated with mwinit' if raw.include? 'You should authenticate'
      raise MWInitFailure, 'You are not authenticated with mwinit -f' if raw.include? 'You did not present a posture cookie'

      regex = /CSRF-TOKEN\t(.*)\n/
      regex.match(raw)[1]
    end
  end
end
