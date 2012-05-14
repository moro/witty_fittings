module WittyFittings
  class Repository
    module ConnectionCapture
      def self.extend_once(conn)
        unless conn.singleton_class.include? self
          conn.extend self
        end
      end

      def insert(*args)
        super.tap {|new_id|
          next unless repo = Thread.current[Repository.variable_name]
          repo.inserted args.first.engine, new_id
        }
      end
    end

    def self.variable_name
      'witty_fitting.current_repository'
    end

    attr_reader :records, :fixtures

    def initialize
      @records = Hash.new {|h, k| h[k] = Set.new }
      @fixtures = Hash.new
    end

    def capture
      ConnectionCapture.extend_once(ActiveRecord::Base.connection)
      begin
        Thread.current[self.class.variable_name] = self
        yield
        load_fixture_data!
      ensure
        @captured = true
        Thread.current[self.class.variable_name] = nil
      end
    end

    def inserted klass, new_id
      @records[klass].add new_id.to_i
    end

    def captured?
      @captured
    end

    private

    def load_fixture_data!
      @records.each do |klass, ids|
        @fixtures[klass] = klass.where(id: ids.to_a).uniq.map(&:attributes)
      end
    end

  end
end
