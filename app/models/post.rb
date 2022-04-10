# frozen_string_literal: true

class Post < ApplicationRecord

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :post_reactions, dependent: :destroy
  has_many :reactions, through: :post_reactions

end
