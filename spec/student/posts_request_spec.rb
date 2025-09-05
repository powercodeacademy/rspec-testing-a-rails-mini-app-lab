require 'rails_helper' 

RSpec.describe "Posts API", type: :request do 
  let(:json) { JSON.parse(response.body) }
  let!(:user) { User.create!(name: "Shantel", email: "shantel@shantel.com") } 

  describe "GET /posts" do 
    it "returns a list of posts (index action)" do 
      Post.create!(title: "A Post", body: "blah blah blah", user: user)
      Post.create!(title: "A Post", body: "blah blah blah", user: user)
      get "/posts" 
      expect(response).to have_http_status(:ok) 
      expect(json.size).to eq(2) 
    end 
  end

  describe "GET /posts/:id" do 
    it "returns a specific post (show action)" do 
      let!(:post) { Post.create!(title: "Post", body: "sldkfjsd", user: user) }
      get "/posts/#{post.id}" 
      expect(response).to have_http_status(:ok) 
      expect(json["title"]).to eq("Post")
    end 
  end

  describe "POST /posts" do 
    it "creates a post (new and create actions)" do 
      post "/posts", params: { post: { title: "test", body: "test", user: user } } 
      expect(response).to have_http_status(:created) 
      expect(json["title"]).to eq("test") 
    end 
  end 

  describe "PATCH /posts/:id" do 
    let!(:post) { Post.create!(title: "a post", body: "blah blah", user: user) } 

    it "updates a post (edit and update actions)" do 
      patch "/posts/#{post.id}", params: { post: { body: "blah blah blah" } } 
      expect(response).to have_http_status(:ok) 
      expect(json["body"]).to eq("blah blah blah") 
    end 
  end

  describe "DELETE /posts/:id" do 
    let!(:post) { Post.create!(title: "another post", body: "sldfkjsdlkgjlsd") } 

    it "deletes a post (destroy action)" do 
      expect {
        delete "/posts/#{post.id}"
      }.to change { Post.count }.by(-1) 
      expect(response).to have_http_status(:no_content).or have_http_status(:success) 
    end 
  end
end
