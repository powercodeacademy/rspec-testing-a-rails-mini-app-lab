# frozen_string_literal: true
require "rails_helper"

describe "Users", type: :request do
  let!(:user) { create(:user) }

  describe "index" do
    it "returns ok" do
      get users_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "show" do
    it "returns ok" do
      get user_path(user)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "new" do
    it "renders new" do
      get new_user_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "edit" do
    it "renders edit" do
      get edit_user_path(user)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "create" do
    it "creates and redirects" do
      expect {
        post users_path, params: { user: attributes_for(:user) }
      }.to change(User, :count).by(1)
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "update" do
    it "updates and redirects" do
      patch user_path(user), params: { user: { name: "Updated" } }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "destroy" do
    it "destroys and redirects" do
      expect {
        delete user_path(user)
      }.to change(User, :count).by(-1)
      expect(response).to have_http_status(:redirect)
    end
  end
end
