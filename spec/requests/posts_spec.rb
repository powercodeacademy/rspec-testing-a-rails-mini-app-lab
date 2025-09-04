require 'rails_helper'

describe "Posts", type: :request do
  let!(:user) { create(:user) }
  let!(:post_record) { create(:post, user: user) } # don't call it :post

  describe "index" do
    it "returns ok" do
      get posts_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "show" do
    it "returns ok" do
      get post_path(post_record)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "new" do
    it "returns ok" do
      get new_post_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "edit" do
    it "returns ok" do
      get edit_post_path(post_record)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "create" do
    it "creates and redirects" do
      expect {
        post posts_path, params: { post: attributes_for(:post, user_id: user.id) }
      }.to change(Post, :count).by(1)
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "update" do
    it "updates and redirects" do
      patch post_path(post_record), params: { post: { title: "New Title" } }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "destroy" do
    it "destroys and redirects" do
      expect {
        delete post_path(post_record)
      }.to change(Post, :count).by(-1)
      expect(response).to have_http_status(:redirect)
    end
  end
end
