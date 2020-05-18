# frozen_string_literal: true
# for exercise
class SlackNotifyService
  def initialize(message = '')
    @message = message
  end

  def perform
    puts 'Print out message below:'
    puts @message
  end
end
