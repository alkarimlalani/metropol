RSpec.describe Metropol::Default do

  describe "#default_headers" do
    it "returns a duplicate object" do
      req = Metropol::Request.new(public_key: 'foo', private_key: 'bar', path: '/', port: 8080, api_version: 'v1')
      expect(req.default_headers).not_to be(Metropol::Default::HEADERS)
    end
  end

end