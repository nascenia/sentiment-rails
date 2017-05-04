password = 'pass123'
1.upto(5) do |i|
  User.create(
    email: "user-#{i}@example.com",
    password: password,
    password_confirmation: password,
    user_name: "user-#{i}"
  )
end
User.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true, user_name: 'admin')
