class CollabsController < ApplicationController
  def show
    session["init"] = true
    puts "session #{session.inspect}"
    puts "session[:eth_address] #{session[:eth_address]} \nENV['RAILS_ENV'] #{ENV['RAILS_ENV']} \nsession[:user_id] #{session[:user_id]}"
    if session[:eth_address]
      session[:current_collab] ||= params[:id]
      puts "session[:eth_address] #{session[:eth_address]} \nENV['RAILS_ENV'] #{ENV['RAILS_ENV']} \nsession[:user_id] #{session[:user_id]}"
      if session[:eth_address]
        @nfts = []
        (1..100).each do |x|
          if params[:debug] == "true"
            response = HTTParty.get("https://api.pentas.io/user/0x440217fb13c1814F7aE170A5fb3eCf6B7FeeB014/nft/collected?page=#{x}&sorting=latest")
          else
            response = HTTParty.get("https://api.pentas.io/user/#{session[:eth_address]}/nft/collected?page=#{x}&sorting=latest")
          end
          # response = HTTParty.get("https://api.pentas.io/user/#{session[:eth_address]}/nft/collected?page=#{x}&sorting=latest") if ENV['RAILS_ENV'] == 'production'
          tmp = JSON.parse(response.body)
          tmp = tmp.select{|x| x["minterDetails"]["address"] == params[:id]}
          @nfts << tmp
          break if JSON.parse(response.body).empty?
        end
        @nfts.flatten!
      end
    else
      session[:current_collab] = params[:id]
      response = HTTParty.get("https://api.pentas.io/user/#{params[:id]}/")
      @artist_profile = JSON.parse(response.body)

    end
  end
end