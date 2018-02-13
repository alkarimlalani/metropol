RSpec.describe Metropol::Request do

  before do
    @req = Metropol::Request.new(public_key: 'foo', private_key: 'bar', path: 'test', port: 8080, api_version: 'v1')
    allow(Time).to receive(:now) { Time.at(1518481464.150067) }
  end

  after do
    @req = nil
  end

  describe "#generate_url" do
    it "returns a string" do
      expect(@req.generate_url).to be_a(String)
    end
    it "returns a correct URL" do
      url = 'https://api.metropol.co.ke:8080/v1/test'
      expect(@req.generate_url).to eq(url)
    end
  end

  describe "#generate_timestamp" do
    it "returns a 20 char string" do
      t = @req.generate_timestamp
      expect(t).to be_a(String)
      expect(t.length).to eq(20)
    end
    it "returns the correct format" do
      expect(@req.generate_timestamp).to eq('20180213002424150067')
    end
  end

  describe "#generate_api_hash" do
    before do
      @timestamp = @req.generate_timestamp
    end
    it "returns a sha256 hexdigest length string" do
      api_hash = @req.generate_api_hash(@timestamp)
      expect(api_hash).to be_a(String)
      expect(api_hash.length).to eq(64)
    end
    it "returns the correct value" do
      api_hash = @req.generate_api_hash(@timestamp)
      expect(api_hash).to eq('de51fe2b8204a15bb6cc2678bc10f2a3774261d64ccd8544485e343745516ba9')
    end
  end

  describe "#generate_headers" do
    it "returns a hash" do
      expect(@req.generate_headers).to be_a(Hash)
    end
    it "has the required keys" do
      headers = @req.generate_headers
      expect(headers['X-METROPOL-REST-API-KEY']).to_not be_nil
      expect(headers['X-METROPOL-REST-API-TIMESTAMP']).to_not be_nil
      expect(headers['X-METROPOL-REST-API-HASH']).to_not be_nil
    end
  end

  describe "#post" do
    let(:uri) { 'https://api.metropol.co.ke:8080/v1/test' }

    before do
      stub_request(:any, uri).to_return(status: 200, body: fixture('true_response.json'))
    end
    it "makes a request" do
      resp = @req.post
      expect(resp).to be_a(Hash)
      expect(resp['true']).to eq(true)
    end
  end
end