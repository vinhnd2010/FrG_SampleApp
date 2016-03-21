User.create!(name:  "ToanLH",
             email: "toan@gmail.com",
             password:              "1",
             password_confirmation: "1",
             admin: true)
             # activated: true,
             # activated_at: Time.zone.now)
User.create!(name:  "ToanLH2",
             email: "toan2@gmail.com",
             password:              "1",
             password_confirmation: "1",
             admin: true)

99.times do |n|
  # binding.pry
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
               # activated: true,
               # activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  title = "Fake content"
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.entries.create!(title: title ,content: content) }
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
