User.create!(
    full_name: 'nakaji',
    email: 'nakaji@abc.com',
    password: '111111',
    password_confirmation: '111111',
    admin: 'true',
  )

20.times do |n|
    name = Faker::Games::Pokemon.name
    email = Faker::Internet.email
    password = "password"
    password_confirmation = "password"
    User.create!(full_name: name,
                 email: email,
                 password: password,
                 password_confirmation: password,
                 admin: false,
                 )
end