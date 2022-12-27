Sequel.migration do
  change do
    create_table(:post_reactions) do
      primary_key :id, unique: true

      foreign_key :post_id, :posts, null: false
      foreign_key :reaction_id, :reactions, null: false

      Integer :count, null: false, default: 0

      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end
