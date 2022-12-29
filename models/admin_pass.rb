class AdminPass < Sequel::Model(DB[:admin_pass])

  def self.take
    first.password_hash
  end

end
