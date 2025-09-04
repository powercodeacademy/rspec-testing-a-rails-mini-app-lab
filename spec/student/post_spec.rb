require 'rails_helper'

RSpec.describe Post, type: :model do
  subject(:post) { build(:post) }
  let(:persisted_post) { create(:post) }

  it "belongs_to a user (association)" do
    user = create(:user)
    post = create(:post, user: user)

    expect(post.user).to eq(user)
    expect(Post.reflect_on_association(:user).macro).to eq(:belongs_to)
  end

  it "validates presence of a user" do
    post = Post.create(title: "Example", body: "Example body")
    expect(post).not_to be_valid
    expect(post.errors[:user]).to include("must exist")
  end

end
