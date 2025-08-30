# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Create some users
user1 = User.find_or_create_by!(email: "alice@example.com") do |u|
  u.name = "Alice"
end

user2 = User.find_or_create_by!(email: "bob@example.com") do |u|
  u.name = "Bob"
end

user3 = User.find_or_create_by!(email: "carol@example.com") do |u|
  u.name = "Carol"
end

user4 = User.find_or_create_by!(email: "dave@example.com") do |u|
  u.name = "Dave"
end

# Create some posts for each user
Post.find_or_create_by!(title: "Hello World", user_id: user1.id) do |p|
  p.body = "This is Alice's first post."
end

Post.find_or_create_by!(title: "Another Post", user_id: user1.id) do |p|
  p.body = "Alice writes again!"
end

Post.find_or_create_by!(title: "Alice's Adventures", user_id: user1.id) do |p|
  p.body = "Alice shares her adventures."
end

Post.find_or_create_by!(title: "Bob's Thoughts", user_id: user2.id) do |p|
  p.body = "Bob shares his thoughts."
end

Post.find_or_create_by!(title: "Bob's Second Post", user_id: user2.id) do |p|
  p.body = "Bob is back with more ideas."
end

Post.find_or_create_by!(title: "Carol's Introduction", user_id: user3.id) do |p|
  p.body = "Carol introduces herself."
end

Post.find_or_create_by!(title: "Carol's Tips", user_id: user3.id) do |p|
  p.body = "Carol shares some useful tips."
end

Post.find_or_create_by!(title: "Dave's Diary", user_id: user4.id) do |p|
  p.body = "Dave starts his diary."
end

Post.find_or_create_by!(title: "Dave's Update", user_id: user4.id) do |p|
  p.body = "Dave gives an update on his progress."
end
