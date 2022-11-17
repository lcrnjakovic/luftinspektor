require 'roda'

class Luftinspektor < Roda
  plugin :public
  plugin :render
  plugin :head

  route do |r|
    r.public

    r.root do
      view('home')
    end
  end
end

