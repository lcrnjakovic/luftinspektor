Sequel.migration do
  change do
    create_table(:admin_pass) do
      primary_key :id, unique: true

      String :password_hash, null: false
    end
  end
end
