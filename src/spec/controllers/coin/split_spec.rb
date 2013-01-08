require_relative "../../../coin_server"

require "rspec"
require "rack/test"

describe CoinServer, "#split" do

  include Rack::Test::Methods

  def app
    CoinServer
  end

  describe "PUT /:id/split/:value" do

    it "should fail with a client error if the given id does not belong to a valid coin" do
      put "/jibberish/split/1"
      last_response.should be_client_error
    end

    it "should fail with a client error if the given value is zero" do
      post "/", :value => 100
      id = last_response.body.gsub( /^.*"id":"([^"]+)".*$/, '\1' )
      put "/#{id}/split/0"
      last_response.should be_client_error
    end

    it "should fail with a client error if the given value is negative" do
      post "/", :value => 100
      id = last_response.body.gsub( /^.*"id":"([^"]+)".*$/, '\1' )
      put "/#{id}/split/-1"
      last_response.should be_client_error
    end

    it "should fail with a client error if the given value is not a valid number" do
      post "/", :value => 100
      id = last_response.body.gsub( /^.*"id":"([^"]+)".*$/, '\1' )
      put "/#{id}/split/jibberish"
      last_response.should be_client_error
    end

    it "should fail with a client error if the given value exceeds the coin's worth" do
      post "/", :value => 100
      id = last_response.body.gsub( /^.*"id":"([^"]+)".*$/, '\1' )
      put "/#{id}/split/101"
      last_response.should be_client_error
    end

    it "should return two coins, one of which has a value equal to the given value, and whose sum is the value of the coin corresponding to the given identifier" do
      post "/", :value => 100
      id = last_response.body.gsub( /^.*"id":"([^"]+)".*$/, '\1' )
      put "/#{id}/split/25"
      last_response.should be_ok
      expect { last_response.body =~ /^\[\{.+\},\{.+\\}\]$/ }.to be_true
      expect { last_response.body =~ /"value":25\}/ }.to be_true
      expect { last_response.body =~ /"value":75\}/ }.to be_true
    end

  end

end
