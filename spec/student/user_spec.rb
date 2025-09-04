require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }
  let(:persisted_user) { create(:user) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:posts).dependent(:destroy) }

  it "has_many posts (association)" do
    posts = create_list(:post, 2, user: persisted_user)
    expect(persisted_user.posts).to match_array(posts)
    expect(User.reflect_on_association(:posts).macro).to eq(:has_many)
  end

  it "rejects blank name" do
    u = build(:user, name: nil)
    expect(u).not_to be_valid
    expect(u.errors[:name]).to include("can't be blank")
  end

  it "rejects duplicate email" do
    create(:user, email: "dupe@example.com")
    u = build(:user, email: "dupe@example.com")
    expect(u).not_to be_valid
    expect(u.errors[:email]).to include("has already been taken")
  end
end
