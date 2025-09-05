require 'rails_helper'

RSpec.describe "Users API", type: :request do
  let!(:user1) { User.create!(name: "Bob", email: "bob@bob.com") }
  let!(:user2) { User.create!(name: "Joe", email: "joe@joe.com") }

  describe "GET /users" do
    it "returns a list of users (index action)" do
      get "/users"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Bob")
      expect(response.body).to include("Joe")
    end
  end

  describe "GET /users/:id" do
    let!(:user) { User.create!(name: "Lisa", email: "lisa@lisa.com") }

    it "returns a specific user (show action)" do
      get "/users/#{user.id}"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Lisa")
      expect(response.body).to include("lisa@lisa.com")
    end
  end

  describe "POST /users" do
    it "creates a user (new and create actions)" do
      expect {
        post "/users", params: { user: { name: "Emily", email: "emily@emily.com" } }
      }.to change { User.count }.by(1)

      # Rails redirects after HTML create
      expect(response).to have_http_status(:redirect).or have_http_status(:found)
    end
  end

  describe "PATCH /users/:id" do
    let!(:user) { User.create!(name: "Jen", email: "jen@jen.com") }

    it "updates a user (edit and update actions)" do
      patch "/users/#{user.id}", params: { user: { email: "jen@jenkelly.com" } }

      expect(response).to have_http_status(:redirect).or have_http_status(:found)
      expect(user.reload.email).to eq("jen@jenkelly.com")
    end
  end

  describe "DELETE /users/:id" do
    let!(:user) { User.create!(name: "Kyle", email: "kyle@kyle.com") }

    it "deletes a user (destroy action)" do
      expect {
        delete "/users/#{user.id}"
      }.to change { User.count }.by(-1)

      # Rails redirects after HTML destroy
      expect(response).to have_http_status(:redirect).or have_http_status(:found)
    end
  end
end
