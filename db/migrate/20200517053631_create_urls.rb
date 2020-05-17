# frozen_string_literal: true

class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.string :long_url
      t.string :short_url
      t.string :note
      t.timestamps
    end
  end
end
