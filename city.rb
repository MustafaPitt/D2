class City
  def initialize(name, id)
    @name = name
    @id = id
    # each instance of city has an array of connection cities, basically each
    # index contains a reference to another city class that prospector can
    # travel to. For example, Sutter Creek city contain 2 connections,
    # connections[0] = the reference of Angles camp and connections[1] =
    # reference of Coloma
    @connections = []
    @max_gold = 0
    @max_sliver = 0
  end

  # @return [city name]
  attr_reader :name

  # @return [city id]
  attr_reader :id

  # @return [connections]
  attr_reader :connections

  def to_s
    print "ID  = #{@id}     City Name = #{@name}
    Max Silver = #{@max_sliver}   Max gold = #{@max_gold}\n"
  end

  # Add a references to connection array
  def connect(value)
    @connections.push value
  end
end
