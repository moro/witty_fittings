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

    def to_module
      origin = self
      Module.new do
        define_method(:origin) { origin }
        origin.readers.each do |name, prc|
          define_method(name.to_sym, &prc)
        end
      end
    end
  end
end
