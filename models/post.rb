class Post < Sequel::Model
  many_to_many :reactions, join_table: :post_reactions
  one_to_many :post_reactions

  def after_create
    Reaction.all.each do |reaction|
      PostReaction.new(post_id: self.id, reaction_id: reaction.id).save
    end
    super
  end
end
