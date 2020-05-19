# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Association' do
    it { should have_many(:urls) }
  end
end
