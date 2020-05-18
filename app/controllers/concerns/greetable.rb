# frozen_string_literal: true
# for exercise
module Greetable
  extend ActiveSupport::Concern

  def say_hello
    puts 'Say hello in concern'
  end
end
