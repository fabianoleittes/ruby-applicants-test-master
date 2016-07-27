require "rails_helper"

describe SearchMakes do
  describe "#create_make" do
    subject(:make) { SearchMakes.new }

    before do
      WebMock.allow_net_connect!
      base_url = URI(ENV.fetch("WEBMOTORS_API_BASE_URL_MAKES"))

      response = Net::HTTP.post_form(base_url, {})

      @json_response = JSON.parse(response.body)

       stub_request(:get, URI(ENV.fetch("WEBMOTORS_API_BASE_URL_MAKES"))).to_return(body: @json_response)
    end

    it "create make" do
      expect(make.create_make(@json_response)).to be_persisted
    end
  end
end
