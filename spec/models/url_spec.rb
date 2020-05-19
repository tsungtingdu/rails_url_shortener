# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'Association' do
    it { should belong_to(:user) }
  end

  describe 'Columns' do
    it 'has four columns' do
      columns = Url.column_names
      expect(columns).to include 'short_url'
      expect(columns).to include 'long_url'
      expect(columns).to include 'count'
      expect(columns).to include 'user_id'
      expect(columns).not_to include 'test'
    end
  end
end
