# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reaction, type: :model do
  it { is_expected.to have_many(:post_reactions) }
end
