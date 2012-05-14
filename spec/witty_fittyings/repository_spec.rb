require 'spec_helper'
require 'logger'
require 'witty_fittings/repository'

describe WittyFittings::Repository do
  let :repository do
    WittyFittings::Repository.new
  end

  let(:lesson) { Lesson.first }

  RSpec::Matchers.define :contain_data do |rows|
    match do |fixtures|
      fixtures.map {|h| h.except('created_at', 'updated_at') } == rows
    end
  end

  context 'create lesson simply' do
    before do
      repository.capture do
        l = Lesson.create! name: '1st Lesson'
      end
      Lesson.create name: '2nd Lesson' # ignored
    end
    specify { repository.records[Lesson].should == Set.new([lesson.id]) }
    specify { repository.fixtures[Lesson].should contain_data([{'id' => lesson.id, 'name' => lesson.name}]) }
  end

  context 'update lesson after create' do
    before do
      repository.capture do
        l = Lesson.create! name: '1st Lesson'
        l.update_attributes! name: 'Great Lesson!!!'
      end
    end
    specify { repository.fixtures[Lesson].should contain_data([{'id' => lesson.id, 'name' => 'Great Lesson!!!'}]) }
  end

  context 'copmlex data graph' do
    before do
      repository.capture do
        l = Lesson.create! name: '1st Lesson'
        p = Person.create! name: 'Alice'
        p.attend(l)
      end
    end

    specify {
      [Lesson, Person, Attendence].should satisfy do |tables|
        tables.all? {|t| repository.fixtures[t].size > 0 }
      end
    }
  end

end

