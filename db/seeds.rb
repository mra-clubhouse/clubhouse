# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Skip seeding if already seeded. This makes the db:seed task idempotent so we can use
# db:prepare unconditionally without worrying if the database has been created yet or not.
return if Message.any?

posts_count = 20
comments_count = 30
messages_count = 30

users = User.create(
  [
    { name: "Alice", username: "alice", password: "password", password_confirmation: "password", email: "alice@example.com" },
    { name: "Bob", username: "bob", password: "password", password_confirmation: "password", email: "bob@example.com" },
    { name: "Cerri", username: "ceri", password: "password", password_confirmation: "password", email: "cerri@example.com" },
    { name: "Dave", username: "dave", password: "password", password_confirmation: "password", email: "dave@example.com" },
  ]
)

posts_attributes = Array.new(posts_count) do
  {
    title: Faker::Company.catch_phrase,
    body: Array.new(6){ Faker::Quote.matz }.join(" "),
    user: users[rand(4)] }
end
posts = Post.create(posts_attributes)

comments_count.times do
  Comment.create({ body: Faker::Quote.matz, user: users[rand(4)], post: posts[rand(posts_count)] })
end

messages_count.times do
  Message.create({ body: Faker::Quote.matz, user: users[rand(4)] })
end
