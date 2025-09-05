RSpec.describe Post, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should belong_to(:user) }

  it "is valid with valid attributes" do 
    post = FactoryBot.build(:post)
    expect(post).to be_valid 
  end 

  it "is invalid without a title" do 
    post = FactoryBot.build(:post, title: nil) 
    expect(post).not_to be_valid 
    expect(post.errors[:title]).to include("can't be blank") 
  end

  it "is invalid without a body" do 
    post = FactoryBot.build(:post, body: nil) 
    expect(post).not_to be_valid 
    expect(post.errors[:body]).to include("can't be blank") 
  end

  it "belongs to a user" do 
    user = FactoryBot.create(:user, email: "anotheruniqueemail@test.com") 
    post1 = FactoryBot.create(:post, user: user) 
    post2 = FactoryBot.create(:post, user: user) 
    expect(user.posts).to contain_exactly(post1, post2) 
    expect(post1.user).to eq(user) 
    expect(post2.user).to eq(user) 
  end
end
