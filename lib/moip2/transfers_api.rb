module Moip2
  class TransfersApi
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def base_path
      "/v2/transfers"
    end

    def show
    end

    def find_all
      Resource::Transfers.new @client, @client.get("#{base_path}")
    end
  end
end
