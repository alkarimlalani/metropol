require 'metropol/client'
require 'metropol/version'

module Metropol

  class << self

    attr_writer :public_key, :private_key, :port, :api_version

    def client
      @client ||= Metropol::Client.new(public_key: @public_key,
                                       private_key: @private_key,
                                       port: @port,
                                       api_version: @api_version)
    end

    # Set configuration variables using a block
    def configure
      yield self
    end

    def method_missing(method_name, *args, &block)
      if client.respond_to?(method_name)
        return client.send(method_name, *args, &block)
      end

      super
    end

    def reset!
      @public_key = nil
      @private_key = nil
      @port = nil
      @api_version = nil
    end

  end

end

