module WittyFittings
  class ReaderMixin
    attr_reader :readers, :fittings
    def initialize(fittings)
      @fittings = fittings
      @readers = {}
    end

    def let(k, &prc)
      @readers[k] = prc
    end

    def setup_module
      _f = fittings
      Module.new do
        define_method :included do |base|
          base.before(:each) { _f.setup }
        end
      end
    end

    def to_module
      origin = self
      m = setup_module
      Module.new do
        extend m

        define_method(:origin) { origin }
        origin.readers.each do |name, prc|
          define_method(name.to_sym, &prc)
        end
      end
    end
  end
end
