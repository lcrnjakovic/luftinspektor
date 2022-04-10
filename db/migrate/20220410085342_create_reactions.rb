# frozen_string_literal: true

class CreateReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :reactions do |t|
      t.string :slug

      t.timestamps
    end
  end
end
