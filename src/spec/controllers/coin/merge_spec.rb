require_relative "../../../coin_server"

require "rspec"
require "rack/test"

describe CoinServer, "#merge" do

  include Rack::Test::Methods

  def app
    CoinServer
  end

  describe "PUT /:id1/merge/:id2" do

    it "should fail with a client error if the first id does not belong to a valid coin" do
      post "/", :value => 100
      id2 = last_response.body.gsub( /^.*"id":"([^"]+)".*$/, '\1' )
      put "/jibberish/merge/#{id2}"
      last_response.should be_client_error
    end

    it "should fail with a client error if the second id does not belong to a valid coin" do
      post "/", :value => 100
      id1 = last_response.body.gsub( /^.*"id":"([^"]+)".*$/, '\1' )
      put "/#{id1}/merge/jibberish"
      last_response.should be_client_error
    end

    it "should return one coin whose value is the sum of the values of the coins corresponding to the given identifiers" do
      post "/", :value => 25
      id1 = last_response.body.gsub( /^.*"id":"([^"]+)".*$/, '\1' )
      post "/", :value => 75
      id2 = last_response.body.gsub( /^.*"id":"([^"]+)".*$/, '\1' )
      put "/#{id1}/merge/#{id2}"
      last_response.should be_ok
      expect { last_response.body =~ /"value":100\}/ }.to be_true
    end

  end

end
