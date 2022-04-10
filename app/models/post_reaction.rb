# frozen_string_literal: true

class PostReaction < ApplicationRecord

  self.table_name = 'posts_reactions'

  belongs_to :post
  belongs_to :reaction

end
