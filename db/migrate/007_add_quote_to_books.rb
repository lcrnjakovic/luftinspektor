Sequel.migration do
  change do
    alter_table(:books) do
      add_column :quote, String, text: true
    end
  end
end
