Sequel.migration do
  change do
    alter_table(:books) do
      set_column_allow_null :year_read
      set_column_allow_null :rating
    end
  end
end
