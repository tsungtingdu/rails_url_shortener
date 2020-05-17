# frozen_string_literal: true

class AddColumnsToUrl < ActiveRecord::Migration[5.2]
  def change
    add_column :urls, :user_id, :integer
  end
end
