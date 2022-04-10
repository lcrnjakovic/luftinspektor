# frozen_string_literal: true

class CreatePostReactions < ActiveRecord::Migration[7.0]
  def change
    create_join_table :posts, :reactions do |t|
      t.integer :count, null: false, default: 0
      t.string :session_id, null: false
      t.index :post_id
      t.index :reaction_id
    end
  end
end
