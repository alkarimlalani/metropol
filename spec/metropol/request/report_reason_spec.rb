RSpec.describe Metropol::Request::ReportReason do

  before do
    @req = Metropol::Request.new(public_key: 'foo', private_key: 'bar', path: 'test', port: 8080, api_version: 'v1')
  end

  after do
    @req = nil
  end

  describe "#valid_reason?" do
    it "returns a boolean" do
      true_val = @req.valid_reason? :new_credit_app
      false_val = @req.valid_reason? :test
      expect(true_val).to eq(true)
      expect(false_val).to eq(false)
    end
    it "returns correct values" do
      val = @req.valid_reason? :new_credit_app
      expect(val).to eq(Metropol::Request::ReportReason::REASON_TYPES.has_key? :new_credit_app)
      bad_val = @req.valid_reason? :test
      expect(bad_val).to eq(Metropol::Request::ReportReason::REASON_TYPES.has_key? :test)
    end
  end

end