require 'roda'
require 'sequel'
require 'kramdown'
require 'pry'

database = "luftinspektor_development"
user     = 'lukacrnjakovic'
password = ''
DB = Sequel.connect(adapter: 'postgres', database: database, host: '127.0.0.1', user: user, password: password)

Sequel::Model.plugin :timestamps, update_on_create: true

require_relative 'models/post'

class Luftinspektor < Roda
  plugin :public
  plugin :render
  plugin :head

  route do |r|
    r.public

    r.root do
      view('home')
    end

    r.get 'about' do
      view('about')
    end

    r.on 'posts' do
      r.is do
        r.get do
          @posts = Post.all
          view('posts/index')
        end
      end

      r.get String do |slug|
        @post = Post.find(slug: slug)
        view('posts/show')
      end
    end
  end
end

