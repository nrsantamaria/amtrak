class City
   attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes[:id]
  end

  def City.all
    result = DB.exec('SELECT * FROM cities')
    cities = []
    result.each() do |city|
      name = city.fetch('name')
      id = city.fetch('id').to_i
      cities.push(City.new({:name => name, :id => id}))
    end
    cities
  end

  def save
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first['id'].to_i()
  end

  def ==(another_city)
    self.name.==(another_city.name).&(self.id.==(another_city.id))
  end

  def City.find(id)
    City.all.each do |city|
      if city.id == id
        return city
      end
    end
  end

  def update(attributes)
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{self.id()};")

    attributes.fetch(:train_ids, []).each() do |train_id|
      DB.exec("INSERT INTO stops (city_id, train_id) VALUES (#{self.id}, #{train_id});")
    end
  end

  def trains
  city_trains = []
  results = DB.exec("SELECT train_id FROM stops WHERE city_id = #{self.id()};")
  results.each() do |result|
    train_id = result.fetch("train_id").to_i()
    train = DB.exec("SELECT * FROM trains WHERE id = #{train_id};")
    name = train.first().fetch("name")
    city_trains.push(City.new({:name => name, :id => train_id}))
  end
  city_trains
  end

  def delete
    DB.exec("DELETE FROM stops WHERE city_id = #{self.id()};")
    DB.exec("DELETE FROM cities WHERE id = #{self.id()};")
  end

end
