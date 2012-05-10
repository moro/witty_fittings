require 'active_record'

ActiveRecord::Base.establish_connection({
  adapter: 'sqlite3',
  database: ':memory:'
})

ActiveRecord::Schema.define(:version => 1) do

  create_table 'lessons', force: true do |t|
    t.string 'name', null: false
    t.timestamps
  end

  create_table 'people', force: true do |t|
    t.string 'name', null: false
    t.timestamps
  end

  create_table 'attendences', force: true do |t|
    t.belongs_to :lesson, null: false
    t.belongs_to :person, null: false
  end
end

class Lesson < ActiveRecord::Base
  has_many :attendences, dependent: :destroy
  has_many :attendees, through: :attendences, source: :person
end

class Person < ActiveRecord::Base

end

class Attendence < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :person
end


