describe Moip2::TransfersApi do
  let(:transfers_api) { described_class.new(sandbox_oauth_client) }
  
  describe "#create transfer" do
    let(:create_transfer) do
      VCR.use_cassette("create_transfer") do
        transfer = {
          "amount": 1000,
          "transferInstrument": {
            "method": "BANK_ACCOUNT",
            "bankAccount": {
              "type": "CHECKING",
              "bankNumber": "001",
              "agencyNumber": "1111",
              "agencyCheckNumber": "2",
              "accountNumber": "9999",
              "accountCheckNumber": "8",
              "holder": {
                "fullname": "Nome do Portador",
                "taxDocument": {
                    "type": "CPF",
                    "number": "22222222222"
                }
              }
            }
          }
        }
        transfers_api.create(transfer)
      end
    end
    
    it { expect(create_transfer.id).to eq "TRA-18UC7OQVJAZL" }
    it { expect(create_transfer.amount).to eq 1000 }
    it { expect(create_transfer.fee).to eq 0 }
    it { expect(create_transfer.transfer_instrument['method']).to eq "BANK_ACCOUNT" }
    it { expect(create_transfer.status).to eq "REQUESTED" }   
  end

  describe "#show" do
    let(:transfers_show) do
      VCR.use_cassette("show_transfers") do
          transfers_api.show("TRA-8PBO743QDU9W")
      end
    end

    it "show specific transfer" do
      expect(transfers_show.id).to eq "TRA-8PBO743QDU9W"
    end

    it "verify if fee is present" do
      expect(transfers_show.fee).to eq 0
    end

    it "verify if amount is present" do
      expect(transfers_show.amount).to eq 500
    end

    it "verify if status is present" do
      expect(transfers_show.status).to eq "COMPLETED"
    end

    it "verify if transferInstrument present" do
      expect(transfers_show.transfer_instrument['method']).to eq "BANK_ACCOUNT"
    end

    it "verify if events are present" do
      expect(transfers_show.events).not_to eq nil
    end

    it "verify if entries are present" do
      expect(transfers_show.entries).not_to eq nil
    end
  end


  describe "#find_all" do
    let(:transfers_find_all) do
      VCR.use_cassette("find_all_transfers") do
          transfers_api.find_all
      end
    end

    it { expect(transfers_find_all).to be_a(Moip2::Resource::Transfers) }
    it { expect(transfers_find_all).to_not be_nil }
    it { expect(transfers_find_all['transfers'].count).to eq 20}
  end
end
