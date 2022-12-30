Sequel.migration do
  change do
    create_table(:albums) do
      primary_key :id, unique: true

      String :title, null: false
      String :artist, null: false
      Integer :year, null: false
      String :genre, null: false
      String :cover
      TrueClass :top_five, default: false
      TrueClass :owned, default: false

      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end
