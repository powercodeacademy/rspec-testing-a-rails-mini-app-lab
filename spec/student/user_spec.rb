require 'rails_helper' 

RSpec.describe User, type: :model do
  subject(:user) { FactoryBot.build(:user, email: "uniqueemail@test.com") }
  let(:existing_user) { FactoryBot.create(:user, email: "test@example.com") }
  let(:post_owner) { FactoryBot.create(:user, email: "ownerofposts@test.com") }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:posts).dependent(:destroy) }

  it "is valid with valid attributes" do 
    expect(user).to be_valid 
  end 

  it "is invalid without a name" do 
    user.name = nil 
    expect(user).not_to be_valid 
    expect(user.errors[:name]).to include("can't be blank") 
  end

  it "is invalid without an email" do 
    user.email = nil 
    expect(user).not_to be_valid 
    expect(user.errors[:email]).to include("can't be blank") 
  end

  it "is invalid with a duplicate email" do 
    existing_user 
    duplicate_user = FactoryBot.build(:user, email: "test@example.com") 
    
    expect(duplicate_user).not_to be_valid 
    expect(duplicate_user.errors[:email]).to include("has already been taken") 
  end

  it "can have many posts" do 
    post1 = FactoryBot.create(:post, user: post_owner) 
    post2 = FactoryBot.create(:post, user: post_owner) 
    expect(post_owner.posts).to contain_exactly(post1, post2) 
    expect(post1.user).to eq(post_owner) 
    expect(post2.user).to eq(post_owner) 
  end
end
