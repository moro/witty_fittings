Feature: WitFit provides dynamic fixture set.

  As a TDD love class-ist programmer,
  I want to define and load well-trained fixture data set.
  Because I want to manage both real data-graph and test speed.

  Scenario: run integrated witty fitting, skip heavy generation logic on sencond call.
    Given a file named "attendence_with_heavy_data_spec.rb" with:
      """
      require 'spec_helper'
      require './lesson_wittings'

      describe Lesson do
        include WittyFittings['a *person* attends a *lesson*']

        context 'one person attends the lesson' do
          subject &:lesson

          its(:attendees) { should include(person) }
          it { should have(1).attendees }
        end
      end
      """
    Given a file named "lesson_wittings.rb" with:
      """
      require 'witty_fittings/dsl'

      WittyFittings.define 'a *person* attends a *lesson*' do
        n = 0

        fittings do
          Kernel.sleep n * 5
          n += 1

          l = Lesson.create! name: '1st Lesson'
          p = Person.create! name: 'Alice'
          p.attend(l)
        end

        let(:person) { Person.find_by_name 'Alice' }
        let(:lesson) { Lesson.find_by_name '1st Lesson' }
      end
      """

    When I run `bundle exec rspec attendence_with_heavy_data_spec.rb`
    Then the examples should all pass
    And  the output should match /Finished in 0.\d+ seconds/

