RSpec.describe Metropol do
  before do
    Metropol.reset!
  end

  after do
    Metropol.reset!
  end

  it "has a version number" do
    expect(Metropol::VERSION).not_to be nil
  end

  describe ".configure" do
    it "yields itself" do
      Metropol.configure do |c|
        expect(c).to eq(Metropol)
      end
    end
    it "sets config values on Metropol" do
      Metropol.configure do |c|
        c.public_key = 'foo'
        c.private_key = 'bar'
        c.port = 8080
        c.api_version = 'v1'
      end
      expect(Metropol.instance_variable_get(:@public_key)).to eq('foo')
      expect(Metropol.instance_variable_get(:@private_key)).to eq('bar')
      expect(Metropol.instance_variable_get(:@port)).to eq(8080)
      expect(Metropol.instance_variable_get(:@api_version)).to eq('v1')
    end
  end

  describe ".client" do
    it "creates a Metropol::Client" do
      expect(Metropol.client).to be_kind_of Metropol::Client
    end
  end

end
