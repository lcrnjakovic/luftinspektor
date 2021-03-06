# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { is_expected.to have_many(:post_tags) }
  it { is_expected.to have_many(:posts).through(:post_tags) }
end
