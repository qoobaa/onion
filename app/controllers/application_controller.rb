# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate

  private

  def authenticate
    Current.user = User.find_by(id: session[:user_id])
  end

  def require_user
    redirect_to root_path unless Current.user?
  end

  def require_no_user
    redirect_to root_path if Current.user?
  end
end
