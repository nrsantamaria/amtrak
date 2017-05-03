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
end
