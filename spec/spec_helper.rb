require'rspec'
require'pg'
require'train'
require'city'
require'stop'

DB = PG.connect({:dbname => 'amtrak_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("TRUNCATE cities, trains, stops;")
  end
end
