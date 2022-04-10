require 'rails_helper'

RSpec.describe Post, type: :model do

  it { is_expected.to have_many(:post_tags) }
  it { is_expected.to have_many(:tags).through(:post_tags) }
  it { is_expected.to have_many(:post_reactions) }
  it { is_expected.to have_many(:reactions).through(:post_reactions) }

end
