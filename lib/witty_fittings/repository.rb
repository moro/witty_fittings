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

    attr_reader :records

    def initialize
      @records = Hash.new {|h, k| h[k] = Set.new }
    end

    def capture
      ConnectionCapture.extend_once(ActiveRecord::Base.connection)
      begin
        Thread.current[self.class.variable_name] = self
        yield
      ensure
        Thread.current[self.class.variable_name] = nil
      end
    end

    def inserted klass, new_id
      @records[klass].add new_id.to_i
    end

    def captured?
      false
    end
  end
end
