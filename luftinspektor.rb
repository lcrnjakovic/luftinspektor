require 'roda'

class Luftinspektor < Roda
  route do |r|
    r.root do
      'Hello!'
    end
  end
end

