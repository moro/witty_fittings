module WittyFittings
  module Dsl
    WittyFittings.extend self

    def [](name)
      Module.new do
        def person
        end

        def lesson
        end
      end
    end

    def define(name, &block)
    end

    def let(var)
      nil
    end
  end
end
