RSpec.describe Metropol::Request::IdModifier do

  describe "#sort_payload" do
    it "sorts the payload" do
      payload = {
        loan_amount: 1000,
        report_type: 2,
        identity_number: '123',
        identity_type: '001',
        report_reason: 1
      }
      req = Metropol::Request.new(public_key: 'foo', private_key: 'bar', path: 'test', port: 8080, api_version: 'v1', payload: payload)
      req.send(:sort_payload!)
      order = req.instance_variable_get(:@payload).keys
      expect(order).to eq([:report_type, :identity_number, :identity_type, :loan_amount, :report_reason])
    end
  end

end
