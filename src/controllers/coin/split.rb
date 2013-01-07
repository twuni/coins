class CoinServer

  put "/:id/split/:value" do

    # 1. Parse input.
    id = params[:id]
    value = params[:value].to_i

    # 2. Retrieve the model with which we want to work.
    coin = Coin.find_by_id(id)

    # 3. Validate the existence of the model.
    raise Sinatra::NotFound if coin.nil?

    # 4. Perform the action.
    begin
      coins = coin.split(value)
    rescue Exception => exception
      status 400
      return "[ERROR] #{exception.message}"
    end

    # 5. Build the response string.
    json = "["
    json << coins.first.to_json
    json << ","
    json << coins.last.to_json
    json << "]"

    # 6. Send the response.
    json

  end

end
