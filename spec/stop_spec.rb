require'spec_helper'

describe(Stop) do

  describe('#initialize') do
    it('will create a new stop') do
      new_stop = Stop.new({:time => '12:00:00', :date => '2017-11-11'})
      expect(new_stop.time()).to(eq('12:00:00'))
    end
  end
  describe('.all') do
    it('will return an empty array') do
      expect(Stop.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('will add a new stop to the table') do
      new_stop = Stop.new({:time => '12:00:00', :date => '2017-11-11'})
      new_stop.save
      expect(Stop.all()).to(eq([new_stop]))
    end
  end

  describe('#==') do
    it('is the same stop if it has the same information') do
      new_stop = Stop.new({:time => '12:00:00', :date => '2017-11-11'})
      new_stop2 = Stop.new({:time => '12:00:00', :date => '2017-11-11'})
      expect(new_stop).to(eq(new_stop2))
    end
  end

  describe('.find') do
    it('will find a stop by id') do
      new_stop = Stop.new({:time => '12:00:00', :date => '2017-11-11'})
      new_stop.save
      expect(Stop.find(new_stop.id())).to(eq(new_stop))
    end
  end

end
