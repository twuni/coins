class Coin

  @@coins = []

  attr_accessor :id, :value

  def self.create( value )
    raise "value must be > 0." if value <= 0
    coin = new( value )
    @@coins.push(coin)
    coin
  end

  def self.find_by_id( id )
    raise "id cannot be empty." if id.empty?
    @@coins.select { |coin| coin.id == id }.first
  end

  def initialize( value )
    @id = SecureRandom.hex(16)
    @value = value
  end

  def merge( other )
    @@coins.delete(self)
    @@coins.delete(other)
    Coin.create( other.value + @value )
  end

  def split( value )
    raise "value must be < #@value." if value >= @value
    result = []
    result.push( Coin.create( value ) )
    result.push( Coin.create( @value - value ) )
    @@coins.delete(self)
    result
  end

  def to_json
    "{\"id\":\"#@id\",\"value\":#@value}"
  end

end
