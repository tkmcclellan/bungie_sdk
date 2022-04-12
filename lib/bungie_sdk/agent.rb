# typed: true

module BungieSdk
  # Class for authentication token-related exceptions
  class TokenException < StandardError; end

  # Struct used internally to represent Bungie API Responses.
  class ApiResponse < T::Struct
    prop :body, Hash
    prop :headers, Hash
    prop :status, Integer
  end

  # Base class for all BungieSdk resources. Handles creating and running
  # Typhoeus requests, authentication and auth token management, and
  # basic methods for building endpoints.
  class ApiAgent
    extend T::Sig
    attr_accessor :data

    BASE_URI  = 'https://www.bungie.net'.freeze

    sig { params(api_data: T.nilable(Hash)).void }
    def initialize(api_data=nil)
      @data = api_data
    end

    # Runs the given `Typhoeus::Request`, checks for expected errors, and
    # handles refreshing or creating an authentication token for authenticated
    # requests.
    sig { params(request: Typhoeus::Request).returns(ApiResponse) }
    def run(request)
      retries = 0

      begin
        request.run if request.response.nil? || retries == 1

        api_response = process_response(request.response)
        @body        = api_response.body
        @headers     = api_response.headers
        @code        = api_response.status
        if @body['ErrorStatus'] == 'WebAuthRequired'
          TokenManager.instance.web_auth
          throw TokenException
        elsif request.response.options[:return_code] == :couldnt_connect
          TokenManager.instance.refresh_token
          throw TokenException
        end

        api_response
      rescue TokenException
        if retries.zero?
          retries += 1

          options           = request.original_options
          options[:headers] = auth_headers
          request           = Typhoeus::Request.new(
            request.base_url,
            **options
          )
          retry
        else
          throw TokenException.new('Invalid OAuth token')
        end
      end
    end

    # Returns a Typhoeus GET request with the given configuration
    sig do
      params(path: String, params: T.nilable(Hash), body: T.nilable(Hash))
        .returns(Typhoeus::Request)
    end
    def get(path, params: nil, body: nil)
      request(:get, path, params: params, body: body)
    end

    # Returns a Typhoeus PUT request with the given configuration
    sig do
      params(path: String, params: T.nilable(Hash), body: T.nilable(Hash))
        .returns(Typhoeus::Request)
    end
    def put(path, params: nil, body: nil)
      request(:put, path, params: params, body: body)
    end

    # Returns a Typhoeus POST request with the given configuration
    sig do
      params(path: String, params: T.nilable(Hash), body: T.nilable(Hash))
        .returns(Typhoeus::Request)
    end
    def post(path, params: nil, body: nil)
      request(:post, path, params: params, body: body)
    end

    # Returns a Typhoeus DELETE request with the given configuration
    sig do
      params(path: String, params: T.nilable(Hash), body: T.nilable(Hash))
        .returns(Typhoeus::Request)
    end
    def delete(path, params: nil, body: nil)
      request(:delete, path, params: params, body: body)
    end

    # Returns a Typhoeus request with the given configuration
    sig do
      params(method: T.any(String, Symbol),
             path:   String,
             params: T.nilable(Hash),
             body:   T.nilable(Hash))
        .returns(Typhoeus::Request)
    end
    def request(method, path, params: nil, body: nil)
      Typhoeus::Request.new(
        "#{BASE_URI}#{path}",
        followlocation: true,
        method:         method.to_sym,
        params:         params,
        body:           body,
        headers:        auth_headers
      )
    end

    private
    sig { params(response: Typhoeus::Response).returns(ApiResponse) }
    def process_response(response)
      response_headers = response.headers.to_h
      response_code    = response.code
      response_body    = JSON.parse(response.body)['Response']

      ApiResponse.new(body: response_body, headers: response_headers, status: response_code)
    end

    sig { params(manifest_type: String, id: T.any(String, Integer)).returns(Typhoeus::Request) }
    def entity_definition(manifest_type, id)
      get(manifest_url(manifest_type, id))
    end

    sig { params(id: T.any(String, Integer)).returns(Typhoeus::Request) }
    def item_definition(id)
      entity_definition('DestinyInventoryItemDefinition', id)
    end

    sig { params(id: T.any(String, Integer)).returns(Typhoeus::Request) }
    def vendor_definition(id)
      entity_definition('DestinyVendorDefinition', id)
    end

    sig { returns(String) }
    def destiny_url
      '/Platform/Destiny2'
    end

    sig { params(manifest_type: String, id: T.any(String, Integer)).returns(String) }
    def manifest_url(manifest_type, id)
      "#{destiny_url}/Manifest/#{manifest_type}/#{id}"
    end

    sig { returns(Hash) }
    def auth_headers
      {
        'Authorization' => "Bearer #{TokenManager.instance.token.token}",
        'X-API-KEY'     => TokenManager.instance.api_key
      }
    end
  end
end
