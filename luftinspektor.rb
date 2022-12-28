require 'roda'
require 'sequel'
require 'active_support/core_ext/string'
require 'kramdown'
require 'pry'

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
        @post = Post.new
        view("posts/new")
      end

      r.post do
        @post = Post.new(r['post'])
        @post.slug = @post.title.delete("'").parameterize.underscore

        if @post.valid? && @post.save
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
        @book = Book.new
        view('books/new')
      end

      r.post do
        @book= Book.new(r['book'])

        if @book.valid? && @book.save
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
  end
end

