# typed: true
require 'singleton'

# OAuth2 token manager singleton class for the BungieSdk
class BungieSdk::TokenManager
  extend T::Sig
  include Singleton

  attr_reader :token, :api_key

  AUTH_URL  = '/en/Oauth/Authorize'.freeze
  TOKEN_URL = '/Platform/App/Oauth/Token'.freeze
  BASE_URI  = 'https://www.bungie.net'.freeze

  # Setup method for the token manager. Must be called before any
  # API requests are made.
  sig do
    params(user_token:    T.nilable(T.any(OAuth2::AccessToken, String)),
           token_path:    T.nilable(String),
           api_key:       T.nilable(String),
           client_id:     T.nilable(String),
           client_secret: T.nilable(String),
           redirect_uri:  String)
      .void
  end
  def setup_token(user_token,
                  token_path,
                  api_key,
                  client_id,
                  client_secret,
                  redirect_uri)
    @token_path    = token_path
    @api_key       = api_key
    @client_id     = client_id
    @client_secret = client_secret
    @redirect_uri  = redirect_uri

    if !@token_path.nil?
      load_token(@token_path)
    elsif !user_token.nil?
      @token = user_token
    else
      web_auth
    end
  end

  # Tests if this manager has been initialized with an OAuth2 token
  sig { returns T::Boolean }
  def initialized?
    !@token.nil?
  end

  # Loads the OAuth2 access token from file. If that file does not exist,
  # the token is generated through browser based authentication.
  # - `filepath`: location of token file
  sig { params(filepath: String).returns(OAuth2::AccessToken) }
  def load_token(filepath)
    if @token.nil?
      @token = if File.exist?(filepath)
                 load_token_data
               else
                 web_auth
               end
    end

    if @token.expired?
      @token = @token.refresh!
      save_token_data(@token)
    end

    @token
  end

  # Creates an authentication token using the user's web browser.
  sig { returns OAuth2::AccessToken }
  def web_auth
    client   = oauth_client
    auth_url = client.auth_code.authorize_url(redirect_uri: @redirect_uri)
    puts auth_url
    Launchy.open(auth_url) rescue nil
    puts 'Please go to this url, accept the authorization request, '\
         'and copy the code parameter from the url into this program:'
    code       = gets.chomp
    auth_token = client.auth_code.get_token(code)
    save_token_data(auth_token)

    @token = auth_token
  end

  # Refreshes the manager's token.
  sig { returns OAuth2::AccessToken }
  def refresh_token
    @token = @token.refresh!
  end

  # Loads token data from file
  sig { returns OAuth2::AccessToken }
  def load_token_data
    JSON.parse(File.read(@token_path)).yield_self do |token_data|
      OAuth2::AccessToken.new(
        oauth_client,
        token_data['token'],
        refresh_token: token_data['refresh_token'],
        expires_at:    token_data['expires_at']
      )
    end
  end

  # Returns a configured OAuth2 client
  sig { returns OAuth2::Client }
  def oauth_client
    OAuth2::Client.new(
      @client_id,
      @client_secret,
      site:          BASE_URI,
      authorize_url: AUTH_URL,
      token_url:     TOKEN_URL
    )
  end

  # Writes the given auth token to disk
  # - `auth_token`: token to be saved.
  sig { params(auth_token: OAuth2::AccessToken).void }
  def save_token_data(auth_token)
    if @token_path
      File.write(
        @token_path,
        JSON.generate({
          'token'         => auth_token.token,
          'refresh_token' => auth_token.refresh_token,
          'expires_at'    => auth_token.expires_at
        })
      )
    end
  end
end
