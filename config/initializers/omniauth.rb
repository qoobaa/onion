# frozen_string_literal: true

module OmniAuth
  module Strategies
    class Allegro < OmniAuth::Strategies::OAuth2
      option :name, 'allegro'

      option :client_options, {
        site: 'https://allegro.pl',
        authorize_url: '/auth/oauth/authorize',
        token_url: '/auth/oauth/token',
        auth_scheme: :basic_auth,
        redirect_uri: 'http://localhost:3000/auth/allegro/callback'
      }

      option :pkce, true

      uid { raw_info['id'] }

      info do
        {
          login: raw_info['login'],
          first_name: raw_info['firstName'],
          last_name: raw_info['lastName'],
          email: raw_info['email']
        }
      end

      extra do
        {
          raw_info:
        }
      end

      def raw_info
        return @raw_info if defined?(@raw_info)

        @raw_info = access_token.get(
          'https://api.allegro.pl/me',
          headers: { Accept: 'application/vnd.allegro.public.v1+json' }
        ).parsed
      end
    end
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :allegro, Rails.application.credentials.allegro[:client_id],
           Rails.application.credentials.allegro[:client_secret]
end

mime_types = %w[
  application/json
  text/javascript
  application/hal+json
  application/vnd.collection+json
  application/vnd.api+json
  application/problem+json
  application/vnd.allegro.public.v1+json
]

OAuth2::Response.register_parser(:json, mime_types) do |body|
  MultiJson.decode(body)
rescue StandardError
  body
end
