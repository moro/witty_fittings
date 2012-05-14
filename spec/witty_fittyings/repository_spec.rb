require 'spec_helper'
require 'witty_fittings/repository'

describe WittyFittings::Repository do
  let :repository do
    WittyFittings::Repository.new
  end

  before do
    repository.capture do
      Lesson.create! name: '1st Lesson'
    end
  end

  specify { repository.records[Lesson].should == Set.new([Lesson.first.id]) }

end

