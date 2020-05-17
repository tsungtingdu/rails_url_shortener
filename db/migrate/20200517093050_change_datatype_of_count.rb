# frozen_string_literal: true

class ChangeDatatypeOfCount < ActiveRecord::Migration[5.2]
  def change
    remove_column :urls, :count, :string
    add_column :urls, :count, :integer
  end
end
