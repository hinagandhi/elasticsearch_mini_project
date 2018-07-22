class Tweet < ActiveRecord::Base
  include ::Tire::Model::Search
  include ::Tire::Model::Callbacks

  attr_accessible :created_at, :followers_count, :retweet_count, :text, :updated_at

  settings index: { number_of_shards: 1 } do
    mapping dynamic: false do
      indexes :created_at
      indexes :text, analyzer: 'english'
    end
  end

  def self.search_query(query, count)
   tire.search(load: true, per_page: count) do
     query {string query}
   end
 end
end
