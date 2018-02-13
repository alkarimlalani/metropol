require 'uri'
require 'rest-client'
require 'json'
require 'digest'
require 'metropol/default'
require 'metropol/legal_id'
require 'metropol/request/id_modifier'
require 'metropol/request/report_reason'

module Metropol
  class Request
    include Metropol::Default
    include Metropol::LegalId
    include Metropol::Request::IdModifier
    include Metropol::Request::ReportReason

    def initialize(public_key:, private_key:, path:, port:, api_version:, payload: {})
      @public_key = public_key
      @private_key = private_key
      @path = path
      @port = port
      @api_version = api_version
      @payload = payload
    end

    def generate_url
      URI::HTTPS.build(
        host: HOST,
        port: port,
        path: "/#{api_version}/#{@path}"
      ).to_s
    end

    def generate_headers
      timestamp = generate_timestamp
      api_hash = generate_api_hash(timestamp)

      headers = default_headers
      headers['X-METROPOL-REST-API-KEY'] = @public_key
      headers['X-METROPOL-REST-API-TIMESTAMP'] = timestamp
      headers['X-METROPOL-REST-API-HASH'] = api_hash
      headers
    end

    def generate_timestamp
      t = Time.now.utc
      t.strftime('%Y%m%d%H%M%S%6N')
    end

    def generate_api_hash(timestamp)
      json = JSON.generate(@payload)
      str = @private_key + json + @public_key + timestamp
      Digest::SHA256.hexdigest(str.encode('UTF-8'))
    end

    def post
      url = generate_url
      headers = generate_headers
      resp = RestClient.post(url, payload_json, headers)
      JSON.parse resp.body
    end

    private

    def port
      @port || PORT
    end

    def api_version
      @api_version || API_VERSION
    end

    def payload_json
      @payload.to_json
    end

  end
end