class Post < Sequel::Model
  many_to_many :reactions, join_table: :post_reactions
  one_to_many :post_reactions

  AVG_WPM = 238.0

  def after_create
    Reaction.all.each do |reaction|
      PostReaction.new(post_id: self.id, reaction_id: reaction.id).save
    end
    super
  end

  def reading_time
    minutes = (content.split.count / AVG_WPM).round
    "#{minutes} min"
  end
end
