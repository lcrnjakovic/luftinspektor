# frozen_string_literal: true

class Reaction < ApplicationRecord

  has_many :post_reactions, dependent: :destroy

end
