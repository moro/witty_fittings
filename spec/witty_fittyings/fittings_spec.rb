require 'spec_helper'
require 'witty_fittings/fittings'

describe WittyFittings::Fittings do
  def setup_and_rollback(fittings)
    begin
      ActiveRecord::Base.transaction do
        fittings.setup
        raise ActiveRecord::Rollback
      end
    rescue ActiveRecord::Rollback
      return nil
    end
  end

  context 'wittings, can yielded setup only once' do
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
        setup_and_rollback fittings
        flunk 'data lefts' unless Lesson.count.zero?
      end

      specify do
        expect { fittings.setup }.should change(Lesson, :count).by(1)
      end
    end
  end

  context 'setup complex data as fixture' do
    let :fittings do
      WittyFittings::Fittings.new do
        l = Lesson.create! name: '1st Lesson'
        p = Person.create! name: 'Alice'
        p.attend(l)
      end
    end
    let(:lesson) { Lesson.first }

    before do
      setup_and_rollback fittings
      fittings.setup
    end

    specify { lesson.should have(1).attendee }
  end

end

