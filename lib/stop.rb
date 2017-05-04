class Stop
   attr_accessor :time, :date, :id

  def initialize(attributes)
    @time = attributes.fetch(:time)
    @date = attributes.fetch(:date)
    @id = attributes[:id]
  end

  def Stop.all
    results = DB.exec('SELECT * FROM stops;')
    stops = []
    results.each() do |stop|
      time = stop.fetch('arrival_time')
      date = stop.fetch('arrival_date')
      id = stop.fetch('id').to_i
      stops.push(Stop.new({:time => time, :date => date, :id => id}))
    end
    stops
  end

  def save(stop_id)
    result = DB.exec("UPDATE stops SET arrival_time = '#{@time}', arrival_date = '#{@date}' WHERE id = '#{stop_id}';")
  end

  def ==(another_stop)
    self.time.==(another_stop.time).&(self.id.==(another_stop.id))
  end

  def Stop.find(id)
    result = DB.exec("SELECT * FROM stops WHERE id = #{id};")
    time = result.first().fetch('arrival_time')
    date = result.first().fetch('arrival_date')
    Stop.new({:time => time, :date => date, :id => id})
  end
end
