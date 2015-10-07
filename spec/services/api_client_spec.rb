describe APIClient do

  describe "connection timeout" do
    before {
      allow(RestClient::Request).to receive(:execute).and_return("{}")
      allow(described_class).to receive(:rand).and_return(6)
    }

    it 'fails if retry limit reached' do
      expect { described_class.execute('localhost', max_retries: 3) }.to raise_error APIClient::CommunicationError
    end
  end
end
