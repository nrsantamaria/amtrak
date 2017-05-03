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
end
