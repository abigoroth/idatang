class NftsController < ApplicationController
  respond_to :turbo_stream, :html

  def index

  end

  def show
    @nfts = []
    (1..100).each do |x|
      if params[:debug] == "true"
        response = HTTParty.get("https://api.pentas.io/user/0x440217fb13c1814F7aE170A5fb3eCf6B7FeeB014/nft/collected?page=#{x}&sorting=latest")
      else
        response = HTTParty.get("https://api.pentas.io/user/#{params[:id]}/nft/collected?page=#{x}&sorting=latest")
      end
      # response = HTTParty.get("https://api.pentas.io/user/#{params[:id]}/nft/collected?page=#{x}&sorting=latest") if ENV['RAILS_ENV'] == 'production'
      tmp = JSON.parse(response.body)
      # tmp = tmp.select{|x| x["minterDetails"]["address"] == params[:id]}
      @nfts << tmp
      break if JSON.parse(response.body).empty?
    end
    @nfts.flatten!
  end
end