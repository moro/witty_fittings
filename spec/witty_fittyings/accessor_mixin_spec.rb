require 'spec_helper'
require 'witty_fittings/reader_mixin'

describe WittyFittings::ReaderMixin do
  let :accessor_mixin do
    WittyFittings::ReaderMixin.new(nil)
  end

  let :a_object do
    Class.new { def self.before(*ignore); end }.new
  end

  context 'defined foo() method to return "a value"' do
    subject { a_object.foo }

    before do
      accessor_mixin.let(:foo){ 'a value' }
      a_object.singleton_class.send :include, accessor_mixin.to_module
    end

    it { should == 'a value' }

  end

end
