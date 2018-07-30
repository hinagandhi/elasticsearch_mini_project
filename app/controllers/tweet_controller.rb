# create developer account details in twitter to get access tokens
require 'oauth'
require 'rubygems'
require 'base64'
require 'json'
require 'tweets_api_module'

class TweetController < ApplicationController
  include ::Tweets::Api::Module

  def add
    unless params[:keyword].blank?
      keyword = params[:keyword]
      token = request_token
      result = make_api_call(token, keyword)
      parse_data(result['statuses'])
      render :json => {'msg' => "Successfully added data for keyword #{keyword}", 'status' => 200}
    end
    {}
  end

  def search
    count = params[:count].present? ? params[:count] : 100
    lower_date_range = params[:lower_range].present? ? params[:lower_range] : Time.now
    upper_date_range = params[:upper_range].present? ? params[:upper_range] : Time.now
    unless params[:query].blank?
      result = Tweet.search_query(params[:query], count, lower_date_range, upper_date_range)
      render :json => {'result' => parse_elasticsearch_data(result)}
    end
    {}
  end
end
