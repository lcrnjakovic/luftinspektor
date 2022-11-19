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
  plugin :not_found do
    render('not_found')
  end

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
          recent_slug = Post.order(:created_at).first.slug
          r.redirect "/posts/#{recent_slug}"
        end
      end

      r.get String do |slug|
        @post = Post.find(slug: slug)
        return render('not_found') unless @post

        @all_posts = Post.order(:created_at).all
        view('posts/show')
      end
    end
  end
end

