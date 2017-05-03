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
  @cities = City.all()
  @trains = Train.all()
  erb(:admin)
end

get('/customer') do
  erb(:customer)
end

get('/train/:id') do
  @train = Train.find(params.fetch('id').to_i())
  @cities = City.all()
  @city = City.find(params.fetch('id').to_i())
  erb(:train)
end

get('/train_form') do
  erb(:train_form)
end

get('/city_form') do
  erb(:city_form)
end

post('/admin') do
  train_name = params.fetch('new-train')
  train = Train.new({:name => train_name})
  train.save()
  @trains = Train.all()
  redirect('/admin')
end

post('/admin') do
  city_name = params.fetch('new-city')
  city = City.new({:name => city_name})
  city.save()
  @cities = City.all()
  redirect('/admin')
end

get('/city/:id') do
  @city = City.find(params.fetch('id').to_i())
  @trains = Train.all()
  @train = Train.find(params.fetch('id').to_i())
  erb(:city)
end
