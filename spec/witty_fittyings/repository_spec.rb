require 'spec_helper'
require 'logger'
require 'witty_fittings/repository'

describe WittyFittings::Repository do
  let :repository do
    WittyFittings::Repository.new
  end

  let(:lesson) { Lesson.first }

  after { Lesson.delete_all }

  context 'create lesson simply' do
    before do
      repository.capture do
        l = Lesson.create! name: '1st Lesson'
      end
      Lesson.create name: '2nd Lesson' # ignored
    end
    specify { repository.records[Lesson].should == Set.new([lesson.id]) }
    specify { repository.fixtures[Lesson].should == [{'id' => lesson.id, 'name' => lesson.name}] }
  end

  context 'update lesson after create' do
    before do
      repository.capture do
        l = Lesson.create! name: '1st Lesson'
        l.update_attributes! name: 'Great Lesson!!!'
      end
    end
    specify { repository.fixtures[Lesson].should == [{'id' => lesson.id, 'name' => 'Great Lesson!!!'}] }
  end

end

