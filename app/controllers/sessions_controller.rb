class SessionsController < ApplicationController
  skip_forgery_protection
  # protect_from_forgery with: CustomStrategy
  def create
    # users are indexed by eth address here
    user = User.find_by(eth_address: params[:eth_address])
    # if the user with the eth address is on record, proceed
    if user.present?
      # if the user signed the message, proceed
      if params[:eth_signature]
        # the message is random and has to be signed in the ethereum wallet
        message = params[:eth_message]
        signature = params[:eth_signature]
        # note, we use the user address and nonce from our database, not from the form
        user_address = user.eth_address
        user_nonce = user.eth_nonce
        # we embedded the time of the request in the signed message and make sure
        # it's not older than 5 minutes. expired signatures will be rejected.
        custom_title, request_time, signed_nonce = message.split(",")
        request_time = Time.at(request_time.to_f / 1000.0)
        expiry_time = request_time + 300
        # also make sure the parsed request_time is sane
        # (not nil, not 0, not off by orders of magnitude)
        sane_checkpoint = Time.parse "2022-01-01 00:00:00 UTC"
        if request_time and request_time > sane_checkpoint and Time.now < expiry_time
          # enforce that the signed nonce is the one we have on record
          if signed_nonce.eql? user_nonce
            # recover address from signature
            signature_pubkey = Eth::Signature.personal_recover message, signature
            signature_address = Eth::Util.public_key_to_address signature_pubkey
            # if the recovered address matches the user address on record, proceed
            # (uses downcase to ignore checksum mismatch)
            if user_address.downcase.eql? signature_address.to_s.downcase
              # if this is true, the user is cryptographically authenticated!
              session[:user_id] = user.id
              session[:eth_address] = params[:eth_address]
              puts "params[:eth_address] #{params[:eth_address]} \nsession[:eth_address] #{session[:eth_address]}"
              # rotate the random nonce to prevent signature spoofing
              user.eth_nonce = SecureRandom.uuid
              user.save
              # send the logged in user back home
              puts "params[:eth_address] #{params[:eth_address]} \nsession[:eth_address] #{session[:eth_address]}"
              puts "session[:current_collab] #{session[:current_collab]}"
              puts "params[:authenticity_token] #{params[:authenticity_token]}"
              if session[:current_collab]
                redirect_to collab_path(session[:current_collab])
              else
                redirect_to root_path, notice: "Logged in successfully!"
              end
            end
          end
        end
      end
    end
  end

  def index
    render plain: params
  end

  def destroy
    session.delete(:eth_address)
    if session[:current_collab]
    redirect_to collab_path(session[:current_collab])
    else
      redirect_to "/"
    end
  end
end