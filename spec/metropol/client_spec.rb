RSpec.describe Metropol::Client do

  before do
    Metropol.reset!
  end

  after do
    Metropol.reset!
  end

  describe "new Metropol::Client" do
    it "requires both public and private key" do
      expect{ Metropol::Client.new(public_key: 'foo') }.to raise_error(ArgumentError)
      expect{ Metropol::Client.new(private_key: 'bar') }.to raise_error(ArgumentError)
      expect( Metropol::Client.new(public_key: 'foo', private_key: 'bar') ).to be_a(Metropol::Client)
    end
    it "sets both public and private key" do
      client = Metropol::Client.new(public_key: 'foo', private_key: 'bar')
      expect(client.instance_variable_get(:@public_key)).to eq('foo')
      expect(client.instance_variable_get(:@private_key)).to eq('bar')
    end
  end

  describe "#verify" do
    let(:uri) { 'https://api.metropol.co.ke:5555/v2_1/identity/verify' }

    context "when called on an object" do

      before do
        @client = Metropol::Client.new(public_key: 'foo', private_key: 'bar')
        stub_request(:post, uri).to_return(status: 200, body: fixture('verify.json'))
      end

      after do
        @client = nil
      end

      it "returns Metropol::Request without id info" do
        expect(@client.verify).to be_a(Metropol::Request)
      end
      it "makes a post request with id info" do
        resp = @client.verify(id_type: :national_id, id_number: '880000088')
        expect(resp).to be_a(Hash)
      end
      it "responds to id modifier methods" do
        resp = @client.verify.national_id('880000088')
        expect(resp).to be_a(Hash)
      end
    end

    context "when called on the module" do

      before do
        Metropol.configure do |c|
          c.public_key = 'foo'
          c.private_key = 'bar'
        end
        stub_request(:post, uri).to_return(status: 200, body: fixture('verify.json'))
      end

      after do
        @client = nil
      end

      it "returns Metropol::Request without id info" do
        expect(Metropol.verify).to be_a(Metropol::Request)
      end
      it "makes a post request with id info" do
        resp = Metropol.verify(id_type: :national_id, id_number: '880000088')
        expect(resp).to be_a(Hash)
      end
      it "responds to id modifier methods" do
        resp = Metropol.verify.national_id('880000088')
        expect(resp).to be_a(Hash)
      end
    end
  end

  describe "#delinquency_status" do
    let(:uri) { 'https://api.metropol.co.ke:5555/v2_1/delinquency/status' }

    context "when called on an object" do

      before do
        @client = Metropol::Client.new(public_key: 'foo', private_key: 'bar')
        stub_request(:post, uri).to_return(status: 200, body: fixture('delinquency_status.json'))
      end

      after do
        @client = nil
      end

      it "returns Metropol::Request without id info" do
        expect(@client.delinquency_status).to be_a(Metropol::Request)
      end
      it "makes a post request with id info" do
        resp = @client.delinquency_status(id_type: :national_id, id_number: '880000088')
        expect(resp).to be_a(Hash)
      end
      it "responds to id modifier methods" do
        resp = @client.delinquency_status.national_id('880000088')
        expect(resp).to be_a(Hash)
      end
      it "accepts to loan amount param" do
        resp = @client.delinquency_status(loan_amount: 1000).national_id('880000088')
        expect(resp).to be_a(Hash)
      end
    end

    context "when called on the module" do

      before do
        Metropol.configure do |c|
          c.public_key = 'foo'
          c.private_key = 'bar'
        end
        stub_request(:post, uri).to_return(status: 200, body: fixture('verify.json'))
      end

      after do
        @client = nil
      end

      it "returns Metropol::Request without id info" do
        expect(Metropol.delinquency_status).to be_a(Metropol::Request)
      end
      it "makes a post request with id info" do
        resp = Metropol.delinquency_status(id_type: :national_id, id_number: '880000088')
        expect(resp).to be_a(Hash)
      end
      it "responds to id modifier methods" do
        resp = Metropol.delinquency_status.national_id('880000088')
        expect(resp).to be_a(Hash)
      end
      it "accepts to loan amount param" do
        resp = Metropol.delinquency_status(loan_amount: 1000).national_id('880000088')
        expect(resp).to be_a(Hash)
      end
    end
  end

  describe "#credit_score" do
    let(:uri) { 'https://api.metropol.co.ke:5555/v2_1/score/consumer' }

    context "when called on an object" do

      before do
        @client = Metropol::Client.new(public_key: 'foo', private_key: 'bar')
        stub_request(:post, uri).to_return(status: 200, body: fixture('credit_score.json'))
      end

      after do
        @client = nil
      end

      it "returns Metropol::Request without id info" do
        expect(@client.credit_score).to be_a(Metropol::Request)
      end
      it "makes a post request with id info" do
        resp = @client.credit_score(id_type: :national_id, id_number: '880000088')
        expect(resp).to be_a(Hash)
      end
      it "responds to id modifier methods" do
        resp = @client.credit_score.national_id('880000088')
        expect(resp).to be_a(Hash)
      end
    end

    context "when called on the module" do
      before do
        Metropol.configure do |c|
          c.public_key = 'foo'
          c.private_key = 'bar'
        end
        stub_request(:post, uri).to_return(status: 200, body: fixture('verify.json'))
      end

      after do
        @client = nil
      end

      it "returns Metropol::Request without id info" do
        expect(Metropol.credit_score).to be_a(Metropol::Request)
      end
      it "makes a post request with id info" do
        resp = Metropol.credit_score(id_type: :national_id, id_number: '880000088')
        expect(resp).to be_a(Hash)
      end
      it "responds to id modifier methods" do
        resp = Metropol.credit_score.national_id('880000088')
        expect(resp).to be_a(Hash)
      end
    end
  end

  describe "#json_report" do
    let(:uri) { 'https://api.metropol.co.ke:5555/v2_1/report/credit_info' }

    context "when called on an object" do

      before do
        @client = Metropol::Client.new(public_key: 'foo', private_key: 'bar')
        stub_request(:post, uri).to_return(status: 200, body: fixture('json_report.json'))
      end

      after do
        @client = nil
      end

      it "returns Metropol::Request without id info" do
        expect(@client.json_report).to be_a(Metropol::Request)
      end
      it "makes a post request with id info" do
        resp = @client.json_report(id_type: :national_id, id_number: '880000088')
        expect(resp).to be_a(Hash)
      end
      it "responds to id modifier methods" do
        resp = @client.json_report.national_id('880000088')
        expect(resp).to be_a(Hash)
      end
      it "responds to report reason modifier methods" do
        resp = @client.json_report.new_credit_app.national_id('880000088')
        expect(resp).to be_a(Hash)
      end
    end

    context "when called on the module" do
      before do
        Metropol.configure do |c|
          c.public_key = 'foo'
          c.private_key = 'bar'
        end
        stub_request(:post, uri).to_return(status: 200, body: fixture('verify.json'))
      end

      after do
        @client = nil
      end

      it "returns Metropol::Request without id info" do
        expect(Metropol.json_report).to be_a(Metropol::Request)
      end
      it "makes a post request with id info" do
        resp = Metropol.json_report(id_type: :national_id, id_number: '880000088')
        expect(resp).to be_a(Hash)
      end
      it "responds to id modifier methods" do
        resp = Metropol.json_report.national_id('880000088')
        expect(resp).to be_a(Hash)
      end
      it "responds to report reason modifier methods" do
        resp = Metropol.json_report.new_credit_app.national_id('880000088')
        expect(resp).to be_a(Hash)
      end
    end
  end

  describe "#noncredit_data" do
    let(:uri) { 'https://api.metropol.co.ke:5555/v2_1/identity/scrub' }

    context "when called on an object" do

      before do
        @client = Metropol::Client.new(public_key: 'foo', private_key: 'bar')
        stub_request(:post, uri).to_return(status: 200, body: fixture('noncredit_data.json'))
      end

      after do
        @client = nil
      end

      it "returns Metropol::Request without id info" do
        expect(@client.noncredit_data).to be_a(Metropol::Request)
      end
      it "makes a post request with id info" do
        resp = @client.noncredit_data(id_type: :national_id, id_number: '880000088')
        expect(resp).to be_a(Hash)
      end
      it "responds to id modifier methods" do
        resp = @client.noncredit_data.national_id('880000088')
        expect(resp).to be_a(Hash)
      end
    end

    context "when called on the module" do
      before do
        Metropol.configure do |c|
          c.public_key = 'foo'
          c.private_key = 'bar'
        end
        stub_request(:post, uri).to_return(status: 200, body: fixture('verify.json'))
      end

      after do
        @client = nil
      end

      it "returns Metropol::Request without id info" do
        expect(Metropol.noncredit_data).to be_a(Metropol::Request)
      end
      it "makes a post request with id info" do
        resp = Metropol.noncredit_data(id_type: :national_id, id_number: '880000088')
        expect(resp).to be_a(Hash)
      end
      it "responds to id modifier methods" do
        resp = Metropol.noncredit_data.national_id('880000088')
        expect(resp).to be_a(Hash)
      end
    end
  end

end