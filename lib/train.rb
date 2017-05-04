class Train
   attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes[:id]
  end

  def Train.all
    results = DB.exec('SELECT * FROM trains;')
    trains = []
    results.each() do |train|
      name = train.fetch('name')
      id = train.fetch('id').to_i
      trains.push(Train.new({:name => name, :id => id}))
    end
    trains
  end

  def save
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first['id'].to_i()
  end

  def ==(another_train)
    self.name.==(another_train.name).&(self.id.==(another_train.id))
  end

  def Train.find(id)
    result = DB.exec("SELECT * FROM trains WHERE id = #{id};")
    name = result.first().fetch('name')
    Train.new({:name => name, :id => id})
  end

  def update(attributes)
    stop_id = nil
    attributes.fetch(:city_ids, []).each() do |city_id|
      result = DB.exec("INSERT INTO stops (train_id, city_id) VALUES (#{self.id}, #{city_id}) RETURNING id;")
      stop_id = result.first['id'].to_i
    end
    stop_id
  end

  def cities
    train_cities = []
    results = DB.exec("SELECT city_id FROM stops WHERE train_id = #{self.id()};")
    results.each() do |result|
      city_id = result.fetch("city_id").to_i()
      city = DB.exec("SELECT * FROM cities WHERE id = #{city_id};")
      name = city.first().fetch("name")
      train_cities.push(Train.new({:name => name, :id => city_id}))
    end
    train_cities
  end


  def delete
    DB.exec("DELETE FROM stops WHERE train_id = #{self.id()};")
    DB.exec("DELETE FROM trains WHERE id = #{self.id()};")
  end


end
