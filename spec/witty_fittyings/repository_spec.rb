require 'spec_helper'
require 'logger'
require 'witty_fittings/repository'

describe WittyFittings::Repository do
  let :repository do
    WittyFittings::Repository.new
  end

  let(:lesson) { Lesson.first }

  before do
    repository.capture do
      Lesson.create! name: '1st Lesson'
    end
  end

  after { Lesson.delete_all }

  specify { repository.records[Lesson].should == Set.new([lesson.id]) }
  specify { repository.fixtures[Lesson].should == [{'id' => lesson.id, 'name' => lesson.name}] }

end

