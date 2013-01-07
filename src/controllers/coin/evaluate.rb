class CoinServer

  get "/:id" do

    # 1. Parse input.
    id = params[:id]

    # 2. Retrieve the model with which we want to work.
    coin = Coin.find_by_id(id)

    # 3. Validate the existence of the model.
    raise Sinatra::NotFound if coin.nil?

    # 4. Perform the action.
    # !  (No action required.)

    # 5. Build the response string.
    json = coin.to_json

    # 6. Send the response.
    json

  end

end
