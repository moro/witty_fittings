require 'witty_fittings/repository'
require 'witty_fittings/reader_mixin'

module WittyFittings
  class Fittings
    def initialize
      @repository = Repository.new
      @mixin = ReaderMixin.new(self)
    end

    def to_module
      @mixin.to_module
    end

    def fittings(&block)
      @data_creation = block
      self
    end

    def let(variable_name, &block)
      @mixin.let(variable_name, &block)
    end

    def setup
      if @repository.captured?
        insert_fixtures
      else
        capture_insertion(@data_creation)
      end
    end

    private

    def insert_fixtures
      @repository.fixtures.each do |klass, fixtures|
        fixtures.each do |row|
          klass.connection.insert_fixture row, klass.table_name
        end
      end
    end

    def capture_insertion(data_creation)
      @repository.capture(&data_creation)
    end

  end
end
