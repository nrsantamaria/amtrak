require'spec_helper'

describe(City) do

  describe('#initialize') do
    it('will create a new city') do
      new_city = City.new({:name => 'Portland'})
      expect(new_city.name()).to(eq('Portland'))
    end
  end

  describe('.all') do
    it('will return an empty array') do
      expect(City.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('will add a new city to the table') do
      new_city = City.new({:name => 'Portland'})
      new_city.save
      expect(City.all()).to(eq([new_city]))
    end
  end

  describe('#==') do
    it('is the same city if it has the same information') do
      new_city = City.new({:name => 'Portland'})
      new_city2 = City.new({:name => 'Portland'})
      expect(new_city).to(eq(new_city2))
    end
  end

  describe('.find') do
    it('will find a city by id') do
      new_city = City.new({:name => 'Portland'})
      new_city.save
      expect(City.find(new_city.id())).to(eq(new_city))
    end
  end

  describe("#update") do
    it('lets you add a train to a city') do
      new_city = City.new({:name => 'Portland'})
      new_city.save
      cascades = Train.new({:name => 'Cascades'})
      cascades.save()
      acela = Train.new({:name => 'Acela'})
      acela.save()
      new_city.update({:train_ids => [cascades.id(), acela.id()]})
      expect(new_city.trains()).to(eq([cascades, acela]))
    end
  end

  describe('#trains') do
    it('returns all the trains for a particular city') do
      new_city = City.new({:name => 'Portland'})
      new_city.save
      cascades = Train.new({:name => 'Cascades'})
      cascades.save()
      acela = Train.new({:name => 'Acela'})
      acela.save()
      new_city.update({:train_ids => [cascades.id(), acela.id()]})
      expect(new_city.trains()).to(eq([cascades, acela]))
    end
  end

  describe("#delete") do
    it("lets you delete a city from the database") do
      city = City.new({:name => "Portland"})
      city.save()
      city2 = City.new({:name => "Seattle"})
      city2.save()
      city.delete()
      expect(City.all()).to(eq([city2]))
    end
  end
end
