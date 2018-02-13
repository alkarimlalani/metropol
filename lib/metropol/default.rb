module Metropol

  # Default configuration options for Metropol API requests
  module Default

    HOST = 'api.metropol.co.ke'.freeze
    PORT = 5555.freeze
    API_VERSION = 'v2_1'.freeze
    HEADERS = { 'Accept' => 'application/json',
                'Content-Type' => 'application/json' }.freeze

    def default_headers
      return HEADERS.dup
    end

  end
end
