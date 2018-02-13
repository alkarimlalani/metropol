RSpec.describe Metropol::LegalId do

  before do
    @client = Metropol::Client.new(public_key: 'foo', private_key: 'bar')
  end

  after do
    @client = nil
  end

  describe "#code_for" do
    it "returns a string" do
      code = @client.code_for(:national_id)
      expect(code).to be_a(String)
    end
    it "returns correct values" do
      code = @client.code_for(:national_id)
      expect(code).to eq(Metropol::LegalId::ID_TYPES[:national_id])
    end
    it "raises error for invalid type" do
      expect{ @client.code_for(:ssn) }.to raise_error
    end
  end

  describe "#valid_id?" do
    it "returns a boolean" do
      true_val = @client.valid_id? :national_id
      false_val = @client.valid_id? :ssn
      expect(true_val).to eq(true)
      expect(false_val).to eq(false)
    end
    it "returns correct values" do
      val = @client.valid_id? :national_id
      expect(val).to eq(Metropol::LegalId::ID_TYPES.has_key? :national_id)
      bad_val = @client.valid_id? :ssn
      expect(bad_val).to eq(Metropol::LegalId::ID_TYPES.has_key? :ssn)
    end
  end

end