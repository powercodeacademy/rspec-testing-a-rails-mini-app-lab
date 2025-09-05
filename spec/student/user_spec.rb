RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }

  it "is valid with valid attributes" do 
    user = FactoryBot.build(:user)
    expect(user).to be_valid 
  end 

  it "is invalid without a name" do 
    user = FactoryBot.build(:user, name: nil) 
    expect(user).not_to be_valid 
    expect(user.errors[:name]).to include("can't be blank") 
  end

  it "is invalid without an email" do 
    user = FactoryBot.build(:user, email: nil) 
    expect(user).not_to be_valid 
    expect(user.errors[:email]).to include("can't be blank") 
  end

  it "is invalid with a duplicate email" do 
    existing_user = FactoryBot.create(:user) 
    duplicate_user = FactoryBot.build(:user) 
    
    expect(duplicate_user).not_to be_valid 
    expect(duplicate_user.errors[:email]).to include("has already been taken") 
  end
end
