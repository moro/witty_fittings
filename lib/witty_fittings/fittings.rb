require 'witty_fittings/repository'

module WittyFittings
  class Fittings
    def initialize &data_creation
      @data_creation = data_creation
      @repository = Repository.new
    end

    def setup
      if @repository.captured?
        insert_fixtures
      else
        capture_insertion { @data_creation.call }
      end
    end

    def insert_fixtures
      @repository.fixtures.each do |klass, fixtures|
        fixtures.each do |row|
          klass.connection.insert_fixture row, klass.table_name
        end
      end
    end

    def capture_insertion
      @repository.capture { yield }
    end

  end
end
