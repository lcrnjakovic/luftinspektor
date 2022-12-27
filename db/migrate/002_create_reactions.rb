Sequel.migration do
  change do
    create_table(:reactions) do
      primary_key :id, unique: true

      String :slug, null: false

      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end
