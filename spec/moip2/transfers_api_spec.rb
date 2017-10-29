describe Moip2::TransfersApi do
  let(:transfers_api) { described_class.new(sandbox_oauth_client) }

  describe "#show" do
    let(:created_transfers_show) do
      VCR.use_cassette("show_transfers") do
          transfers_api.show("TRA-8PBO743QDU9W")
      end
    end

    it "show specific transfer" do
      expect(created_transfers_show.id).to eq "TRA-8PBO743QDU9W"
    end

    it "verify if fee is present" do
      expect(created_transfers_show.fee).to eq 0
    end

    it "verify if amount is present" do
      expect(created_transfers_show.amount).to eq 500
    end

    it "verify if status is present" do
      expect(created_transfers_show.status).to eq "COMPLETED"
    end

    it "verify if transferInstrument present" do
      expect(created_transfers_show.transfer_instrument['method']).to eq "BANK_ACCOUNT"
    end

    it "verify if events are present" do
      expect(created_transfers_show.events).not_to eq nil
    end

    it "verify if entries are present" do
      expect(created_transfers_show.entries).not_to eq nil
    end
  end

  describe "#find_all" do
    let(:created_transfers_find_all) do
      VCR.use_cassette("find_all_transfers") do
          transfers_api.find_all
      end
    end

    it { expect(created_transfers_find_all).to be_a(Moip2::Resource::Transfers) }
    it { expect(created_transfers_find_all).to_not be_nil }
    it { expect(created_transfers_find_all['transfers'].count).to eq 20}
  end
end
