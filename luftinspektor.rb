require 'roda'

class Luftinspektor < Roda
  plugin :static, ["/images", "/css", "/js"]
  plugin :render
  plugin :head

  route do |r|
    r.root do
      view('home')
    end
  end
end

