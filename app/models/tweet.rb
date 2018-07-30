require 'multi_json'
class Tweet < ActiveRecord::Base
  include ::Tire::Model::Search
  include ::Tire::Model::Callbacks

  attr_accessible :creation_time, :followers_count, :retweet_count, :text, :updated_at

  settings index: { number_of_shards: 1 } do
    mapping dynamic: false do
      indexes :creation_time
      indexes :text, analyzer: 'english'
    end
  end

  def self.search_query(query, count, lower_range, upper_range)
   tire.search(load: true, per_page: count) do
     query do
       filtered do
         query {string query}
         filter :range, creation_time: {gte:  lower_range, lte: upper_range}
      end
     end
   end
 end
end
