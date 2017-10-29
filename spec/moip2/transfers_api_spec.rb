describe Moip2::TransfersApi do
  let(:transfers_api) { described_class.new(sandbox_oauth_client) }

  describe "#show" do
    # let(:created_transfers_show) do
    #   VCR.use_cassette("show_entries") do
    #       transfers_api.show("ENT-2JHP5A593QSW")
    #   end
    # end

    xit "show specific transfers" do
      expect(created_transfers_show.description).to eq "Cartao de credito - Pedido ORD-UF4E00XMFDL1"
    end

    xit "verify if amount present" do
      expect(created_transfers_show.installment.amount).to eq 1
    end

    xit "verify if amount type present" do
      expect(created_transfers_show.type).to eq "CREDIT_CARD"
    end

    xit "verify if status present" do
      expect(created_transfers_show["status"]).to eq "SETTLED"
    end

    xit "verify if events present" do
      expect(created_transfers_show.event_id).to eq "PAY-AQITTDNDKBU9"
    end
  end

  describe "#find_all" do
    let(:created_transfers_find_all) do
      VCR.use_cassette("find_all_transfers") do
          transfers_api.find_all
      end
    end

    it "find all entries" do
      response = created_transfers_find_all['transfers'] 
      expect(response.count).to eq(20)
    end
  end
end
