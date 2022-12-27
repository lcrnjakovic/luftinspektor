class PostReaction < Sequel::Model
  many_to_one :reaction
  many_to_one :post
end
