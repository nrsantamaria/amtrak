require'sinatra'
require'sinatra/reloader'
also_reload('lib/**/*.rb')
require'./lib/train'
require'./lib/city'
require'pg'

DB = PG.connect({:dbname => "amtrak"})

get('/') do
  erb(:index)
end

get('/admin') do
  @trains = Train.all()
  @cities = City.all()
  erb(:admin)
end

get('/customer') do
  erb(:customer)
end

get('/train_form') do
  erb(:train_form)
end

patch("trains/:id") do
  train_id = params.fetch("id").to_i
  @train = Train.find(train_id)
  city_ids = params.fetch("city_ids")
  @train.update({:city_ids => city_ids})
  @cities = City.all()
  erb(:train)
end

get('/city_form') do
  erb(:city_form)
end

get('/trains') do
  @trains = Train.all()
  erb(:trains)
end

post('/trains') do
  train_name = params.fetch('new-train')
  train = Train.new({:name => train_name})
  train.save()
  @trains = Train.all()
  erb(:trains)
end

get('/trains/:id') do
  @train = Train.find(params.fetch('id').to_i())
  @cities = City.all()
  erb(:train)
end

get('/cities') do
  @cities = City.all()
  erb(:cities)
end

post('/cities') do
  city_name = params.fetch('new-city')
  city = City.new({:name => city_name})
  city.save()
  @cities = City.all()
  erb(:cities)
end

get('/cities/:id') do
  @city = City.find(params.fetch('id').to_i())
  @trains = Train.all()
  erb(:city)
end

patch("cities/:id") do
  city_id = params.fetch("id").to_i
  @city = City.find(city_id)
  train_ids = params.fetch("train_ids")
  @city.update({:train_ids => train_ids})
  @trains = Train.all()
  erb(:city)
end
