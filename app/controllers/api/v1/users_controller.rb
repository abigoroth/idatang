require "eth"

class Api::V1::UsersController < ApplicationController
  # creates a public API that allows fetching the user nonce by address
  def show
    user = nil
    response = nil
    # checks the parameter is a valid eth address
    params_address = Eth::Address.new params[:id]
    if params_address.valid?
      # finds user by valid eth address (downcase to prevent checksum mismatchs)
      user = ::User.find_by(eth_address: params[:id].downcase)
    end
    # do not expose full user object; just the nonce
    if user and user.id > 0
      response = [eth_nonce: user.eth_nonce]
    else
      address = params[:id].downcase
      user = ::User.new(eth_address: address, password: address, email: "#{address}@metalab.my", eth_nonce: 1234)
      user.save
      response = [eth_nonce: 1234]
    end
    # return response if found or nil in case of mismatch
    render json: response
  end
end