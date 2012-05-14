require 'spec_helper'
require 'witty_fittings/fittings'

describe WittyFittings::Fittings do
  let :fittings do
    n = 0
    WittyFittings::Fittings.new do
      raise if n > 0
      n += 1
      Lesson.create! name: '1st lesson'
    end
  end

  specify do
    expect { fittings.setup }.should change(Lesson, :count).by(1)
  end

  context 'called setup once and rolled-back' do
    before do
      Lesson.transaction { fittings.setup; raise ActiveRecord::Rollback } rescue nil
    end

    specify do
      expect { fittings.setup }.should change(Lesson, :count).by(1)
    end
  end

end

