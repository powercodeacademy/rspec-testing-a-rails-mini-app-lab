require 'rails_helper' 

RSpec.describe "Users API", type: :request do 
  let(:json) { JSON.parse(response.body) }

  describe "GET /users" do 
    it "returns a list of users (index action)" do 
      User.create!(name: "Bob", email: "bob@bob.com")
      User.create!(name: "Joe", email: "joe@joe.com") 
      get "/users" 
      expect(response).to have_http_status(:ok) 
      expect(json.size).to eq(2) 
    end 
  end

  describe "GET /users/:id" do 
    it "returns a specific user (show action)" do 
      let!(:user) { User.create!(name: "Lisa", email: "lisa@lisa.com") }
      get "/users/#{user.id}" 
      expect(response).to have_http_status(:ok) 
      expect(json["name"]).to eq("Lisa")
    end 
  end

  describe "POST /users" do 
    it "creates a user (new and create actions)" do 
      post "/users", params: { user: { name: "Emily", email: "emily@emily.com" } } 
      expect(response).to have_http_status(:created) 
      expect(json["name"]).to eq("Emily") 
    end 
  end 

  describe "PATCH /users/:id" do 
    let!(:user) { User.create!(name: "Jen", email: "jen@jen.com") } 

    it "updates a user (edit and update actions)" do 
      patch "/users/#{user.id}", params: { user: { email: "jen@jenkelly.com" } } 
      expect(response).to have_http_status(:ok) 
      expect(json["email"]).to eq("jen@jenkelly.com") 
    end 
  end

  describe "DELETE /users/:id" do 
    let!(:user) { User.create!(name: "Kyle", email: "kyle@kyle.com") } 

    it "deletes a user (destroy action)" do 
      expect {
        delete "/users/#{user.id}"
      }.to change { User.count }.by(-1) 
      expect(response).to have_http_status(:no_content).or have_http_status(:success) 
    end 
  end
end
