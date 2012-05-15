require 'spec_helper'
require 'witty_fittings/reader_mixin'

describe WittyFittings::ReaderMixin do
  let :accessor_mixin do
    WittyFittings::ReaderMixin.new({
      foo: -> { 'a value' },
    })
  end

  let(:a_object) { Object.new }

  context 'defined foo() method to return "a value"' do
    subject { a_object.foo }

    before do
      a_object.singleton_class.send :include, accessor_mixin.to_module
    end

    it { should == 'a value' }

  end

end
