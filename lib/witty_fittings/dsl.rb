require 'forwardable'
require 'witty_fittings/fittings'

module WittyFittings
  module Dsl
    WittyFittings.extend self

    class Proxy < BasicObject
      extend ::Forwardable

      def_delegators '@fittings', :let, :fittings

      def initialize(fittings)
        @fittings = fittings
      end
    end

    def [](name)
      @__fittings__[name].to_module
    end

    def define(name, &block)
      @__fittings__ ||= {}
      @__fittings__[name] = WittyFittings::Fittings.new
      Proxy.new(@__fittings__[name]).instance_eval(&block)
    end
  end
end
