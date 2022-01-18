# frozen_string_literal: true

class User < ApplicationRecord
  has_many :orders

  encrypts :access_token, :refresh_token

  def self.find_or_create_by_auth(auth)
    user = find_or_create_by(uid: auth['uid'])

    user.update!(
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      login: auth.info.login,
      email: auth.info.email,
      access_token: auth.credentials.token,
      refresh_token: auth.credentials.refresh_token
    )

    user
  end
end
