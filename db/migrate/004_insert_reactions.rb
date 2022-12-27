Sequel.migration do
  up do
    %w[heart lightbulb].each do |reaction|
      from(:reactions).insert(slug: reaction, created_at: Time.now, updated_at: Time.now)
    end
  end

  down do
    run 'DELETE * FROM reactions'
  end
end
