# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

users = User.create(
  [
    { name: "Alice", username: "alice", password: "password", password_confirmation: "password", email: "alice@example.com" },
    { name: "Bob", username: "bob", password: "password", password_confirmation: "password", email: "bob@example.com" },
    { name: "Cerri", username: "ceri", password: "password", password_confirmation: "password", email: "cerri@example.com" },
    { name: "Dave", username: "dave", password: "password", password_confirmation: "password", email: "dave@example.com" },
  ]
)

posts_attributes = Array.new(5) do
  {
    title: Faker::Company.catch_phrase,
    body: Array.new(3){ Faker::Quote.matz }.join(" "),
    user: users[rand(4)] }
end
posts = Post.create(posts_attributes)

8.times do
  Comment.create({ body: Faker::Quote.matz, user: users[rand(4)], post: posts[rand(5)] })
end

5.times do
  Message.create({ body: Faker::Quote.matz, user: users[rand(4)] })
end
