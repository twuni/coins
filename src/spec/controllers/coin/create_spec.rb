require_relative "../../../coin_server"

require "rspec"
require "rack/test"

describe CoinServer, "#create" do

  include Rack::Test::Methods

  def app
    CoinServer
  end

  describe "POST /" do

    it "should create a token when given a valid value" do
      post "/", :value => 100
      last_response.should be_ok
      last_response.body.should match(/"value":100/)
    end

    it "should fail to create a token with a client error when given an invalid value" do
      post "/", :value => -1
      last_response.should be_client_error
    end

  end

end
