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
end
