require'spec_helper'

describe(Train) do

  describe('#initialize') do
    it('will create a new train') do
      new_train = Train.new({:name => 'Cascades'})
      expect(new_train.name()).to(eq('Cascades'))
    end
  end

  describe('.all') do
    it('will return an empty array') do
      expect(Train.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('will add a new train to the table') do
      new_train = Train.new({:name => 'Cascades'})
      new_train.save
      expect(Train.all()).to(eq([new_train]))
    end
  end

  describe('#==') do
    it('is the same train if it has the same information') do
      new_train = Train.new({:name => 'Cascades'})
      new_train2 = Train.new({:name => 'Cascades'})
      expect(new_train).to(eq(new_train2))
    end
  end

  describe('.find') do
    it('will find a train by id') do
      new_train = Train.new({:name => 'Cascades'})
      new_train.save
      expect(Train.find(new_train.id())).to(eq(new_train))
    end
  end

  describe("#update") do
    it("lets you update trains in the database") do
      new_train = Train.new({:name => 'Cascades'})
      new_train.save
      new_train.update({:name => "Acela"})
      expect(new_train.name()).to(eq("Acela"))
    end
    it('lets you add a city to a train') do
      new_train = Train.new({:name => 'Cascades'})
      new_train.save
      portland_city = City.new({:name => 'Portland'})
      portland_city.save()
      seattle_city = City.new({:name => 'Seattle'})
      seattle_city.save()
      new_train.update({:city_ids => [portland_city.id(), seattle_city.id()]})
      expect(new_train.cities()).to(eq([portland_city, seattle_city]))
    end
  end

  describe('#cities') do
    it('returns all the cities for a particular train') do
      new_train = Train.new({:name => 'Cascades'})
      new_train.save
      portland_city = City.new({:name => 'Portland'})
      portland_city.save()
      seattle_city = City.new({:name => 'Seattle'})
      seattle_city.save()
      new_train.update({:city_ids => [portland_city.id(), seattle_city.id()]})
      expect(new_train.cities()).to(eq([portland_city, seattle_city]))
    end
  end

  describe("#delete") do
    it("lets you delete a train from the database") do
      train = Train.new({:name => "Cascades"})
      train.save()
      train2 = Train.new({:name => "Acela"})
      train2.save()
      train.delete()
      expect(Train.all()).to(eq([train2]))
    end
  end
end
