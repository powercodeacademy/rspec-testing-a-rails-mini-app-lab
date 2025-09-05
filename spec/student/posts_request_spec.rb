require 'rails_helper' 

RSpec.describe "Posts API", type: :request do 
  let!(:user) { User.create!(name: "Shantel", email: "shantel@shantel.com") } 

  describe "GET /posts" do 
    it "returns a list of posts (index action)" do 
      post1 = Post.create!(title: "A Post", body: "blah blah blah", user: user)
      post2 = Post.create!(title: "Another Post", body: "more blah", user: user)

      get "/posts"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("A Post")
      expect(response.body).to include("Another Post")
    end 
  end

  describe "GET /posts/:id" do 
    let!(:post) { Post.create!(title: "Post", body: "sldkfjsd", user: user) }

    it "returns a specific post (show action)" do 
      get "/posts/#{post.id}"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Post")
      expect(response.body).to include("sldkfjsd")
    end 
  end

  describe "POST /posts" do 
    it "creates a post (new and create actions)" do 
      expect {
        post "/posts", params: { post: { title: "test", body: "test", user_id: user.id } }
      }.to change { Post.count }.by(1)

      expect(response).to have_http_status(:redirect).or have_http_status(:found)
    end 
  end

  describe "PATCH /posts/:id" do 
    let!(:post) { Post.create!(title: "a post", body: "blah blah", user: user) } 

    it "updates a post (edit and update actions)" do 
      patch "/posts/#{post.id}", params: { post: { body: "blah blah blah" } }

      expect(response).to have_http_status(:redirect).or have_http_status(:found)
      expect(post.reload.body).to eq("blah blah blah")
    end 
  end

  describe "DELETE /posts/:id" do 
    let!(:post) { Post.create!(title: "another post", body: "sldfkjsdlkgjlsd", user: user) } 

    it "deletes a post (destroy action)" do 
      expect {
        delete "/posts/#{post.id}"
      }.to change { Post.count }.by(-1)

      expect(response).to have_http_status(:redirect).or have_http_status(:found)
    end 
  end
end
