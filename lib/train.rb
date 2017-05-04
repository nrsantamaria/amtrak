class Train
   attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes[:id]
  end

  def Train.all
    result = DB.exec('SELECT * FROM trains')
    trains = []
    result.each() do |train|
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
    Train.all.each do |train|
      if train.id == id
        return train
      end
    end
  end

  def update(attributes)
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{self.id()};")

    attributes.fetch(:city_ids, []).each() do |city_id|
      DB.exec("INSERT INTO stops (train_id, city_id) VALUES (#{self.id}, #{city_id});")
    end
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
