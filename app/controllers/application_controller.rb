class ApplicationController < ActionController::Base
  # protect_from_forgery unless: -> { ENV["RAILS_ENV"] == "development" }
  before_action :check_csrff

  def check_csrff
    Rails.logger.info "@@@ check_csrff authenticity_token #{params[:authenticity_token]}"
  end
end
