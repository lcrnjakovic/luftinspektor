require 'roda'
require 'sequel'
require 'active_support/core_ext/string'
require 'kramdown'
require 'pry'
require 'bcrypt'

database = "luftinspektor_development"
user     = 'lukacrnjakovic'
password = ''
DB = Sequel.connect(adapter: 'postgres', database: database, host: '127.0.0.1', user: user, password: password)

Sequel::Model.plugin :validation_helpers
Sequel::Model.plugin :timestamps, update_on_create: true

require_relative 'models/post'
require_relative 'models/reaction'
require_relative 'models/post_reaction'
require_relative 'models/book'
require_relative 'models/admin_pass'
require_relative 'models/album'

class Luftinspektor < Roda
  plugin :public
  plugin :render
  plugin :head
  plugin :not_found do
    render('not_found')
  end
  plugin :cookies

  route do |r|
    r.public

    r.root do
      view('home')
    end

    r.get 'about' do
      view('about')
    end

    r.get 'post_reactions' do
      post_reaction = PostReaction.find(id: r[:id])
      old_count = post_reaction.count
      if !r.cookies["reaction_#{post_reaction.id}"]
        new_count = old_count + 1
        post_reaction.update(count: new_count)
        response.set_cookie("reaction_#{post_reaction.id}", true)
      else
        new_count = old_count - 1
        post_reaction.update(count: new_count)
        response.delete_cookie("reaction_#{post_reaction.id}")
      end
      r.redirect "/posts/#{post_reaction.post.slug}"
    end

    r.on 'posts' do
      r.get 'new' do
        if BCrypt::Password.new(AdminPass.take) == r[:pass]
          @post = Post.new
          view("posts/new")
        else
          render('not_found')
        end
      end

      r.post do
        @post = Post.new(r['post'])
        @post.slug = @post.title.delete("'").parameterize.underscore

        if @post.valid? && BCrypt::Password.new(AdminPass.take) == r['pass'] && @post.save
          r.redirect "/"
        else
          view("posts/new")
        end
      end

      r.is do
        r.get do
          recent_slug = Post.last.slug
          r.redirect "/posts/#{recent_slug}"
        end
      end

      r.get String do |slug|
        @post = Post.find(slug: slug)
        @cookies = r.cookies
        return render('not_found') unless @post

        @all_posts = Post.reverse_order(:created_at).all
        view('posts/show')
      end
    end

    r.on 'books' do
      r.get 'new' do
        if BCrypt::Password.new(AdminPass.take) == r[:pass]
          @book = Book.new
          view('books/new')
        else
          render('not_found')
        end
      end

      r.post do
        @book= Book.new(r['book'])

        if @book.valid? && BCrypt::Password.new(AdminPass.take) == r['pass'] && @book.save
          r.redirect "/"
        else
          view("books/new")
        end
      end

      r.is do
        r.get do
          @books = Book.order(:author)
          view('books/index')
        end
      end
    end

    r.get 'chess'  do
      view('chess')
    end

    r.on 'music' do
      r.get 'new' do
        if BCrypt::Password.new(AdminPass.take) == r[:pass]
          @album = Album.new
          view('music/new')
        else
          render('not_found')
        end
      end

      r.post do
        @album = Album.new(r['album'])

        if @album.valid? && BCrypt::Password.new(AdminPass.take) == r['pass'] && @album.save
          r.redirect "/"
        else
          view("music/new")
        end
      end

      r.is do
        @top_albums = Album.where(top_five: true).all
        @owned_albums = Album.where(owned: true).all
        view('music/index')
      end
    end
  end
end

