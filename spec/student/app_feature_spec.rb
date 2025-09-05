require 'rails_helper' 

RSpec.describe "Users index page", type: :system do 
  let(:user1) { FactoryBot.create(:user, name: "Nihar", email: "nihar@nihar.com") }
  let(:user2) { FactoryBot.create(:user, name: "Mike", email: "mike@mike.com") }

  before { visit users_path }
  
  it "displays all users with their details" do 

    expect(page).to have_content("All Users") 

    within("table") do 
      expect(page).to have_content("Nihar")
      expect(page).to have_content("nihar@nihar.com")
      expect(page).to have_content("Mike")
      expect(page).to have_content("mike@mike.com") 
    end 
  end 
end

RSpec.describe "Posts index page", type: :system do 
  let(:user) { FactoryBot.create(:user, name: "Stove", email: "stove@stove.com") }
  let(:post1) { FactoryBot.create(:post, title: "First Post", body: "First Body", user: user) }
  let(:post2) { FactoryBot.create(:post, title: "Second Post", body: "Second Body", user: user) }

  before { visit posts_path }
  
  it "displays all posts with their details" do 

    expect(page).to have_content "All Posts" 

    within("table") do 
      within("tr", text: "First Post").do 
        expect(page).to have_content("First Body")
        expect(page).to have_content("Stove") 
      end

      within("tr", text: "Second Post").do 
        expect(page).to have_content("Second Body")
        expect(page).to have_content("Stove") 
      end
    end 
  end
