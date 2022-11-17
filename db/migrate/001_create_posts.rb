Sequel.migration do
  change do
    create_table(:posts) do
      primary_key :id, unique: true

      String :title, null: false
      String :content, text: true, default: ""
      String :slug, null: false

      DateTime :created_at, null: false
      DateTime :updated_at, null: false

      index :created_at
    end
  end
end
