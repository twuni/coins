describe Coin do

  describe "#create" do

    it "should raise an error if the given value is not a number" do
      expect { Coin.create(nil) }.to raise_error # Equivalence class: Nil
      expect { Coin.create("test") }.to raise_error # Equivalence class: Strings
      expect { Coin.create(self) }.to raise_error # Equivalance class: Objects
      expect { Coin.create([1]) }.to raise_error # Equivalence class: Arrays
      expect { Coin.create( { test: 123 } ) }.to raise_error # Equivalence class: Hashes
    end

    it "should raise an error if the given value is not a positive number" do
      expect { Coin.create(-1) }.to raise_error # Equivalence class: Negative integers
      expect { Coin.create(0) }.to raise_error # Equivalence class: Zero
      expect { Coin.create(-0.1) }.to raise_error # Equivalence class: Negative floating point numbers
    end

    it "should create a coin whose value is identical to the value provided" do
      Coin.create(1).value.should == 1 # Equivalence class: Positive integers
      Coin.create(0.1).value.should == 0.1 # Equivalence class: Positive floating point numbers
    end

  end

  describe "#find_by_id" do

    it "should return nil if no coin exists whose identifier is identical to the given identifier" do
      Coin.find_by_id("test").should be_nil # Equivalence class: Non-existing identifier
    end

    it "should return a coin whose identifier is identical to the identifier provided" do
      coin = Coin.create(1)
      Coin.find_by_id(coin.id).id.should == coin.id
    end

    it "should return a coin whose value is identical to the value used to create it" do
      coin = Coin.create(1)
      Coin.find_by_id(coin.id).value.should == 1
    end

  end

  describe "#split" do

    it "should raise an error if the value provided is not a positive number" do
      coin = Coin.create(2)
      expect { coin.split(-1) }.to raise_error # Equivalence class: Negative integers
      expect { coin.split(-0.1) }.to raise_error # Equivalence class: Negative floating point numbers
      expect { coin.split(0) }.to raise_error # Equivalence class: Zero
    end

    it "should raise an error if the value provided exceeds or equals the coin's value" do
      coin = Coin.create(2)
      expect { coin.split(2) }.to raise_error # Equivalence class: Exact boundary
      expect { coin.split(3) }.to raise_error # Equivalence class: Integer above boundary
      expect { coin.split(2.1) }.to raise_error # Equivalence class: Floating point number above boundary
    end

    it "should invalidate the original coin" do
      coin = Coin.create(2)
      coin.split(1)
      Coin.find_by_id(coin.id).should be_nil
    end

    it "should return exactly two coins" do
      coin = Coin.create(2)
      coin.split(1).size.should == 2
    end

    it "should return exactly two coins wherein the sum of their values is equal to the value of the original coin" do

      # Equivalence class: Resulting coins have equal values
      coin = Coin.create(2)
      coins = coin.split(1)
      ( coins.first.value + coins.last.value ).should == coin.value

      # Equivalence class: Resulting coins have different values
      coin = Coin.create(3)
      coins = coin.split(1)
      ( coins.first.value + coins.last.value ).should == coin.value

    end

  end

  describe "#merge" do

    it "should invalidate the coins being merged" do
      a = Coin.create(1)
      b = Coin.create(2)
      a.merge(b)
      Coin.find_by_id(a.id).should be_nil
      Coin.find_by_id(b.id).should be_nil
    end

    it "should raise an error if the coin provided is no longer valid" do
      a = Coin.create(1)
      b = Coin.create(2)
      b.split(1) # Invalidate b
      expect { a.merge(b) }.to raise_error
    end

    it "should return a coin whose value is identical to the sum of the values of the two coins which correspond to the identifiers provided" do
      a = Coin.create(1)
      b = Coin.create(2)
      c = a.merge(b)
      c.value.should == a.value + b.value
    end

  end

end
