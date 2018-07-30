class Tweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.timestamp :creation_time
      t.text :text
      t.integer :followers_count
      t.integer :retweet_count
      t.timestamps
    end
  end
end
