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
end
