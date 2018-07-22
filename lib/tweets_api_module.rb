module Tweets
  module Api
    module Module
      CONSUMER_KEY = 'pXXsgQtjF2nOohYMr0hdg5xP9'
      CONSUMER_SECRET = 'lmdExL7fKJiHhPchVyYHTKaAsaRjDKJIaJoolB6MMGuTlTGH6n'
      def request_token
        credentials = Base64.encode64("#{CONSUMER_KEY}:#{CONSUMER_SECRET}").gsub("\n", '')
        url = "https://api.twitter.com/oauth2/token"
        body = "grant_type=client_credentials"
        headers = {
                   "Authorization" => "Basic #{credentials}",
                   "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8"
                  }
        r = HTTParty.post(url, body: body, headers: headers)
        bearer_token = JSON.parse(r.body)['access_token']
        {"Authorization" => "Bearer #{bearer_token}"}
      end

      def make_api_call(token, keyword)
        url = "https://api.twitter.com/1.1/search/tweets.json?q=#{keyword}&count=100"
        HTTParty.get(url, headers: token)
      end

      def parse_data(result)
        for tweet in result
          t = Tweet.new
          t.created_at = tweet['created_at']
          t.text = tweet['text']
          t.followers_count = tweet['followers_count']
          t.retweet_count = tweet['retweet_count']
          t.updated_at = tweet['updated_at']
          t.save!
        end
      end

      def parse_elasticsearch_data(result)
        final_search_result = Array.new
        for r in result
          final_search_result << {'created_at' => r.created_at, 'text' => r.text}
        end
        final_search_result
      end
    end
  end
end
