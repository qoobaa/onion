# frozen_string_literal: true

class RefreshTokensJob < ApplicationJob
  def perform(user)
    @user = user
    new_access_token = old_access_token.refresh!
    user.update!(access_token: new_access_token.token, refresh_token: new_access_token.refresh_token)
  end

  private

  def client
    OAuth2::Client.new(
      Rails.application.credentials.allegro[:client_id],
      Rails.application.credentials.allegro[:client_secret],
      site: 'https://allegro.pl',
      token_url: '/auth/oauth/token',
      auth_scheme: :basic_auth
    )
  end

  def old_access_token
    OAuth2::AccessToken.from_hash(client, access_token: @user.access_token, refresh_token: @user.refresh_token)
  end
end
