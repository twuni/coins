class CoinServer

  put "/:id1/merge/:id2" do

    # 1. Parse input.
    id1 = params[:id1]
    id2 = params[:id2]

    # 2. Retrieve the models with which we want to work.
    a = Coin.find_by_id(id1)
    b = Coin.find_by_id(id2)

    # 3. Validate the existence of both models.
    raise Sinatra::NotFound if a.nil? || b.nil?

    # 4. Perform the action.
    begin
      c = a.merge(b)
    rescue Exception => exception
      status 400
      return "[ERROR] #{exception.message}"
    end

    # 5. Build the response string.
    json = c.to_json

    # 6. Send the response.
    json

  end

end
