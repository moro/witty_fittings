module WittyFittings
  class ReaderMixin
    attr_reader :readers
    def initialize(readers)
      @readers = readers
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
