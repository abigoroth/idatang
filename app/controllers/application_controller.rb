class ApplicationController < ActionController::Base
  # TODO: always aware to make any other form submission in future, eg registration etc.
  # protect_from_forgery with: :null_session
  # skip_forgery_protection

  def get_address
    signature_pubkey = Eth::Signature.personal_recover params[:message], params[:signature]
    signature_address = Eth::Util.public_key_to_address signature_pubkey
    user = User.find_by(eth_address: signature_address.to_s.downcase)
    if user
      puts 1
      # TODO: check for expirary.
      sign_time = params[:message].split(",")[1]

      sign_time = Time.at(sign_time.to_f / 1000.0)
      expiry_time = sign_time + 300
      if Time.now < expiry_time
        render json: {
          signature_address: signature_address,
        }
      else
        render json: { expired: true }
      end

    else
      render json: { signature_address: false }
    end

  end
end
