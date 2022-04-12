# typed: true

module BungieSdk
  # Base class for the BungieSdk. All workflows should start with a `Client`.
  #
  # This class currently expects the user to authenticate with OAuth in order to
  # access private API endpoints. This will be changed in the future to allow users
  # to not provide an authentication token if they only wish to access public Bungie
  # API endpoints. Bungie Applications can be created [here](https://www.bungie.net/en/Application).
  #
  # The authentication workflow for this SDK allows for a couple of different options.
  # First, if you already have a valid `OAuth2::AccessToken` for your Bungie Application,
  # you can provide that to the `token` parameter on creation of this class and this
  # application will handle refreshing the token when need be. If you do not already
  # have an access token, you can provide your Bungie Application's client id and client secret
  # to their respective arguments in this class's constructor and this application will
  # handle authentication with those credentials. Optionally, if you would like to save your access
  # token to your local filesystem, provide a path for that file in the `token_filepath` parameter.
  # If a filepath is provided in `token_filepath` but no access token is supplied through `token`, then
  # this application will attempt to read that token from file and use it for authentication. This
  # is recommended as it will reduce the number of times you need to authenticate this app in your
  # web browser. If `token_filepath` is supplied, `token` is not, and there is no existing token
  # stored in the file at `token_filepath`, then this application will require the user to
  # authenticate through their web browser and then save that information to file.
  class Client < ApiAgent
    # Client Constructor.
    # - `token`: Optional; `OAuth2::Access` token for your Bungie Application
    # - `token_filepath`: Optional; Path to read/write your Bungie Application's access token.
    # - `api_key`: Bungie API key for your Bungie Application.
    # - `client_id`: Bungie client id for your Bungie Application.
    # - `client_secret`: Bungie client secret for your Bungie Application.
    # - `redirect_uri`: OAuth2 redirect uri for your Bungie Application. Must match your Bungie
    # Appliation's redirect uri configuration.
    sig do
      params(token:          T.nilable(T.any(OAuth2::AccessToken, String)),
             token_filepath: T.nilable(String),
             api_key:        T.nilable(String),
             client_id:      T.nilable(String),
             client_secret:  T.nilable(String),
             redirect_uri:   String)
        .void
    end
    def initialize(token:          nil,
                   token_filepath: nil,
                   api_key:        ENV['BUNGIE_API_KEY'],
                   client_id:      ENV['BUNGIE_CLIENT_ID'],
                   client_secret:  ENV['BUNGIE_CLIENT_SECRET'],
                   redirect_uri:   ENV['BUNGIE_REDIRECT_URI'] || 'http://localhost:8080/oauth/callback')
      super(nil)
      unless TokenManager.instance.initialized?
        TokenManager.instance.setup_token(token,
                                          token_filepath,
                                          api_key,
                                          client_id,
                                          client_secret,
                                          redirect_uri)
      end
    end

    # Returns memberships associated with the current user's Bungie account.
    sig { returns Hash }
    def memberships
      @memberships ||= run(get('/Platform/User/GetMembershipsForCurrentUser')).body
    end

    # Returns Destiny Memberships associated with the current user's Bungie account.
    sig { returns T::Array[Destiny2::Membership] }
    def destiny_memberships
      memberships['destinyMemberships'].map {|data| Destiny2::Membership.new(data) }
    end
  end
end
