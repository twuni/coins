require "sinatra/base"

class CoinServer < Sinatra::Base

  not_found do
    "Not Found"
  end

  error do
    env["sinatra.error"].message
  end

end

require_relative "controllers/index"
require_relative "models/index"
