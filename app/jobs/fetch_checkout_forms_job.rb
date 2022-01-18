# frozen_string_literal: true

class FetchCheckoutFormsJob < ApplicationJob
  def perform(user)
    @user = user

    orders = []

    loop do
      response = access_token.get('/order/checkout-forms', headers:, params: { offset: orders.size }).parsed
      break if (response['count']).zero?

      orders += response['checkoutForms']
    end

    orders
  end

  private

  def client
    OAuth2::Client.new(
      Rails.application.credentials.allegro[:client_id],
      Rails.application.credentials.allegro[:client_secret],
      site: 'https://api.allegro.pl'
    )
  end

  def access_token
    OAuth2::AccessToken.from_hash(client, access_token: @user.access_token)
  end

  def headers
    { Accept: 'application/vnd.allegro.public.v1+json' }
  end
end
