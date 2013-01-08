require_relative "../../../coin_server"

require "rspec"
require "rack/test"

describe CoinServer, "#evaluate" do

  include Rack::Test::Methods

  def app
    CoinServer
  end

  describe "GET /:id" do

    it "should fail with a client error if the given id does not belong to a valid coin" do
      get "/jibberish"
      last_response.should be_client_error
    end

    it "should return the coin matching the given id" do
      post "/", :value => 100
      id = last_response.body.gsub( /^.*"id":"([^"]+)".*$/, '\1' )
      get "/#{id}"
      last_response.should be_ok
      expect { last_response.body =~ id }.to be_true
    end

  end

end
