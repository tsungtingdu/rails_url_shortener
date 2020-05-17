# frozen_string_literal: true

class AddCountToUrl < ActiveRecord::Migration[5.2]
  def change
    add_column :urls, :count, :string
  end
end
