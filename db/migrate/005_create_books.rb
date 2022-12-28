Sequel.migration do
  change do
    create_table(:books) do
      primary_key :id, unique: true

      String :title, null: false
      String :author, null: false
      String :status, null: false
      String :type, null: false
      Integer :rating, null: false
      Integer :year_read, null: false

      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end
