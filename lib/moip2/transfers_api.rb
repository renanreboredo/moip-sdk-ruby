module Moip2
  class TransfersApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def base_path
      "/v2/transfers"
    end

    def create(transfer)
      Resource::Transfers.new client, client.post("#{base_path}", transfer)
    end

    def show(id)
      Resource::Transfers.new client, client.get("#{base_path}/#{id}")
    end

    def find_all
      Resource::Transfers.new client, client.get("#{base_path}")
    end
  end
end
