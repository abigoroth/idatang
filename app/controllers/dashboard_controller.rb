require 'httparty'
class DashboardController < ApplicationController
  def index
    puts "session[:eth_address] #{session[:eth_address]} \nENV['RAILS_ENV'] #{ENV['RAILS_ENV']} \nsession[:user_id] #{session[:user_id]}"
    if session[:eth_address]
      @nfts = []
      (1..100).each do |x|
        response = HTTParty.get("https://api.pentas.io/user/#{session[:eth_address]}/nft/collected?page=#{x}&sorting=latest") if ENV['RAILS_ENV'] == 'production'
        response = HTTParty.get("https://api.pentas.io/user/0x440217fb13c1814F7aE170A5fb3eCf6B7FeeB014/nft/collected?page=#{x}&sorting=latest") if ENV['RAILS_ENV'] == 'development'
        @nfts << JSON.parse(response.body)
        break if JSON.parse(response.body).empty?
      end
      @nfts.flatten!
    end
  end
end