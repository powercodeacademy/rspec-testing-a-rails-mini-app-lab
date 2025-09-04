# spec/student/app_feature_spec.rb
# Write your feature spec(s) here. This should test user-facing behavior using Capybara.

# Use describe and it blocks as shown in the lessons.
require 'rails_helper'

RSpec.describe "New User", type: :system do

  it "loads the page" do
    visit "/users/new"
    expect(page).to have_content("New User")
  end
  it "allows a user to create user" do
    visit "/users/new"
    fill_in "Name", with: "Nihar Patel"
    fill_in "Email", with: "nkp52@hotmail.com"
    click_button "Sign Up"
    expect(page).to have_content("Account created")
  end
end
