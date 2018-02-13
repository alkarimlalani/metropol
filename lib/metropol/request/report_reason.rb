module Metropol
  class Request
    module ReportReason

      REASON_TYPES = {
        new_credit_app: 1,
        credit_review: 2,
        verify_credit_info: 3,
        customer_request: 4
      }.freeze

      def valid_reason?(reason_type)
        REASON_TYPES.has_key? reason_type
      end

      # Adds methods to specify the report reason
      # Usage:
      # > client.json_report.new_credit_app.national_id('880000088')
      def method_missing(method_name, *args, &block)
        if valid_reason? method_name
          @payload[:report_reason] = REASON_TYPES[method_name]
          return self
        end

        super
      end

    end
  end
end