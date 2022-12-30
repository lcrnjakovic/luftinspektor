require 'pry'
require 'bcrypt'
require 'sequel'

DB = Sequel.connect(adapter: 'postgres', database: 'luftinspektor_development', host: '127.0.0.1', user: 'lukacrnjakovic', password: '')

require_relative '../../models/admin_pass'

desc 'Task to create the admin pass used to create new records'
task :create_admin_pass, [:pass] do |t, args|
  AdminPass.new(password_hash: BCrypt::Password.create(args[:pass])).save
end
