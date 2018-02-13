require 'metropol/legal_id'
require 'metropol/request'

module Metropol
  class Client
    include Metropol::LegalId

    def initialize(public_key:, private_key:, port: nil, api_version: nil)
      @public_key = public_key
      @private_key = private_key
      @port = port
      @api_version = api_version
    end

    def verify(id_type: nil, id_number: nil)
      payload = {report_type: 1}
      path = 'identity/verify'
      fetch(path, payload, id_type, id_number)
    end

    def delinquency_status(loan_amount: 0, id_type: nil, id_number: nil)
      payload = {report_type: 2, loan_amount: loan_amount}
      path = 'delinquency/status'
      fetch(path, payload, id_type, id_number)
    end

    def credit_score(id_type: nil, id_number: nil)
      payload = {report_type: 3}
      path = 'score/consumer'
      fetch(path, payload, id_type, id_number)
    end

    def json_report(loan_amount: 0, report_reason: 1, id_type: nil, id_number: nil)
      payload = {report_type: 8, loan_amount: loan_amount, report_reason: report_reason}
      path = 'report/credit_info'
      fetch(path, payload, id_type, id_number)
    end

    def noncredit_data(id_type: nil, id_number: nil)
      payload = {report_type: 6}
      path = 'identity/scrub'
      fetch(path, payload, id_type, id_number)
    end

    private

    # If a valid ID Type and number are given then
    # returns a JSON object with the response payload.
    # Else returns a Metropol::Request object that needs
    # the ID Type and number data added to its payload
    def fetch(path, payload, id_type, id_number)
      request = unsent_request(path, payload)

      if has_id_info? id_type, id_number
       return request.send(id_type, id_number)
      end

      request
    end

    def unsent_request(path, payload)
      Request.new(public_key: @public_key,
                  private_key: @private_key,
                  path: path,
                  port: @port,
                  api_version: @api_version,
                  payload: payload)
    end

    def has_id_info?(id_type, id_number)
      valid_id?(id_type) && !(id_number.nil?)
    end

  end
end