class CoinServer

  post "/" do

    # 1. Parse input.
    value = params[:value].to_i

    # 2. Retrieve the model with which we want to work.
    # !  (No retrieval required.)

    # 3. Validate the existence of the model.
    # !  (No model to validate.)

    # 4. Perform the action.
    begin
      coin = Coin.create(value)
    rescue Exception => exception
      status 400
      return "[ERROR] #{exception.message}"
    end

    # 5. Build the response string.
    json = coin.to_json

    # 6. Send the response.
    json

  end

end
