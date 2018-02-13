module Metropol
  class Request
    # Methods to allow requests to specify legal ID in the method call
    module IdModifier

      # Add methods to specify the identity type and number
      # of the request
      # Usage:
      # > client.verify.national_id('880000088')
      def method_missing(method_name, *args, &block)
        if valid_id? method_name
          @payload[:identity_number] = args.first
          @payload[:identity_type] = code_for(method_name)
          sort_payload!
          return post
        end

        super
      end

      private

      # Sorts the payload so that the first three params are:
      # :report_type, :identity_number, :identity_type and
      # then the remaining are in the order that they were
      # inserted into the hash
      #
      # Note:
      # - The Metropol API throws an error if the params
      # are not in the order specified in their documentation.
      # We rely on Ruby's sorted hashes to ensure that parameters
      # are in order of insert
      # - We implicitly assume that the keys :report_type,
      # :identity_number and :identity_type are inserted in that order
      def sort_payload!
        partition = @payload.partition do |key, value|
          [:report_type, :identity_number, :identity_type].include? key
        end
        @payload = partition.flatten(1).to_h
      end

    end
  end
end