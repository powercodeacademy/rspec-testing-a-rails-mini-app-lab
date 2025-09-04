# spec/student/app_feature_spec.rb
# Write your feature spec(s) here. This should test user-facing behavior using Capybara.

# Use describe and it blocks as shown in the lessons.
require 'rails_helper'

RSpec.describe "New User", type: :system do
  before do
    visit "/users/new"
    let(:user) { build(:user) }
  end

  it "loads the page" do
    expect(page).to have_content("New User")
  end
  it "allows a user to create user" do
    fill_in "Name", with: user.name
    fill_in "Email", with: user.email
    click_button "Submit"
    expect(page).to have_content("Account created")
  end
end

RSpec.describe "New Post", type: :system do
  before do
    visit "/posts/new"
    subject(:post) { build(:post) }
  end

  it "loads the page" do
    expect(page).to have_content("New Post")
  end
  it "allows a user to create a post" do
    fill_in "Title", with: post.title
    fill_in "Body", with: post.body
    click_button "Submit"
    expect(page).to have_content("Account created")
  end
end
