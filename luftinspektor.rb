require 'roda'
require 'sequel'

database = "luftinspektor_development"
user     = ENV['PGUSER']
password = ENV['PGPASSWORD']
DB = Sequel.connect(adapter: 'postgres', database: database, host: '127.0.0.1', user: user, password: password)

class Luftinspektor < Roda
  plugin :public
  plugin :render
  plugin :head

  Sequel::Model.plugin :timestamps, update_on_create: true

  route do |r|
    r.public

    r.root do
      view('home')
    end

    r.get 'about' do
      view('about')
    end
  end
end

